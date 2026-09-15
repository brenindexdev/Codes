import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db } from '../database/db';

export default function WorkoutActive() {
  const { dayId } = useParams();
  const navigate = useNavigate();
  
  const exercises = useLiveQuery(async () => {
    const list = await db.workoutExercises.where('workoutDayId').equals(Number(dayId)).toArray();
    return Promise.all(list.map(async (we) => {
      const ex = await db.exercises.get(we.exerciseId);
      return { ...we, details: ex };
    }));
  }, [dayId]);

  const [currentIndex, setCurrentIndex] = useState(0);
  const [currentSet, setCurrentSet] = useState(1);
  
  // Controle da Sessão Atual
  const [sessionId, setSessionId] = useState<number | null>(null);
  const [startTime] = useState(Date.now());
  const [workoutFinished, setWorkoutFinished] = useState(false);

  // Inputs de Registro
  const [reps, setReps] = useState(0);
  const [weight, setWeight] = useState(0);
  const [rir, setRir] = useState(2);
  
  // Timer State
  const [isResting, setIsResting] = useState(false);
  const [timeLeft, setTimeLeft] = useState(0);

  // Criar sessão no DB ao carregar a página pela primeira vez
  useEffect(() => {
    if (dayId && !sessionId) {
      db.workoutSessions.add({
        date: new Date().toISOString().split('T')[0],
        workoutDayId: Number(dayId),
        duration: 0,
        completed: false
      }).then(id => setSessionId(id));
    }
  }, [dayId, sessionId]);

  // Seta valores default quando o exercício é alterado
  useEffect(() => {
    if (exercises && exercises[currentIndex]) {
      setReps(exercises[currentIndex].minReps);
      setWeight(exercises[currentIndex].targetWeight);
    }
  }, [currentIndex, exercises]);

  // Timer Countdown
  useEffect(() => {
    if (isResting && timeLeft > 0) {
      const timer = setTimeout(() => setTimeLeft(t => t - 1), 1000);
      return () => clearTimeout(timer);
    } else if (isResting && timeLeft === 0) {
      if (navigator.vibrate) navigator.vibrate([200, 100, 200]);
    }
  }, [isResting, timeLeft]);

  // Detecta quando o treino chega ao fim para marcar como concluído no banco
  useEffect(() => {
    if (exercises && currentIndex >= exercises.length && sessionId && !workoutFinished) {
      const durationMinutes = Math.floor((Date.now() - startTime) / 60000);
      db.workoutSessions.update(sessionId, { 
        completed: true, 
        duration: durationMinutes 
      });
      setWorkoutFinished(true);
    }
  }, [currentIndex, exercises, sessionId, startTime, workoutFinished]);

  if (!exercises) return <div className="p-6 text-white h-full flex items-center justify-center">Carregando treino...</div>;
  
  if (workoutFinished) {
    return (
      <div className="h-full flex flex-col items-center justify-center p-6 text-center bg-dark-900">
        <h1 className="text-6xl mb-4">🏆</h1>
        <h2 className="text-2xl font-bold text-white mb-2">Treino Concluído!</h2>
        <p className="text-gray-400 mb-8">Ótimo trabalho. Seus dados foram salvos offline.</p>
        <button onClick={() => navigate('/')} className="bg-brand-500 text-white py-4 px-8 rounded-xl font-bold text-lg active:scale-95 transition-transform">
          Voltar ao Início
        </button>
      </div>
    );
  }

  const ex = exercises[currentIndex];

  const handleCompleteSet = async () => {
    if (sessionId && ex.details?.id) {
      await db.setRecords.add({
        sessionId,
        exerciseId: ex.details.id,
        setNumber: currentSet,
        reps,
        weight,
        rir
      });
    }
    
    if (currentSet < ex.sets) {
      setCurrentSet(s => s + 1);
      setTimeLeft(ex.restSeconds);
      setIsResting(true);
    } else {
      setCurrentIndex(i => i + 1);
      setCurrentSet(1);
      setTimeLeft(60); 
      setIsResting(true);
    }
  };

  if (isResting) {
    return (
      <div className="h-full flex flex-col items-center justify-center bg-dark-900 p-6">
        <h2 className="text-gray-400 text-lg uppercase tracking-widest mb-2">Descanso</h2>
        <div className={`text-7xl font-black mb-8 ${timeLeft === 0 ? 'text-green-500' : 'text-white'}`}>
          {Math.floor(timeLeft / 60).toString().padStart(2, '0')}:{(timeLeft % 60).toString().padStart(2, '0')}
        </div>
        
        <div className="flex gap-4 mb-12 w-full justify-center">
          <button onClick={() => setTimeLeft(t => t + 15)} className="bg-dark-700 text-white px-6 py-4 rounded-xl font-bold text-lg active:bg-dark-600">+15s</button>
          <button onClick={() => setTimeLeft(t => t + 30)} className="bg-dark-700 text-white px-6 py-4 rounded-xl font-bold text-lg active:bg-dark-600">+30s</button>
        </div>

        <button onClick={() => setIsResting(false)} className={`w-full text-white font-bold py-5 rounded-2xl text-xl transition-colors ${timeLeft === 0 ? 'bg-green-600' : 'bg-brand-500'}`}>
          {timeLeft === 0 ? 'PRÓXIMA SÉRIE' : 'PULAR DESCANSO'}
        </button>
      </div>
    );
  }

  return (
    <div className="p-5 h-full flex flex-col bg-dark-900">
      <div className="flex justify-between items-center mb-6">
        <span className="text-brand-500 font-bold bg-brand-500/10 px-3 py-1 rounded-full text-sm">
          Série {currentSet} de {ex.sets}
        </span>
        <button onClick={() => navigate('/')} className="text-red-400 text-sm font-bold bg-red-400/10 px-3 py-1 rounded-full">✕ Abandonar</button>
      </div>

      <h1 className="text-3xl font-black text-white leading-tight mb-2">{ex.details?.name}</h1>
      <p className="text-gray-400 mb-6">Meta: <span className="text-white font-bold">{ex.minReps}–{ex.maxReps}</span> repetições</p>

      <div className="flex-1 flex flex-col justify-center gap-5">
        <div className="flex justify-between items-center bg-dark-800 p-5 rounded-2xl border border-dark-700 shadow-sm">
          <span className="text-gray-300 font-semibold text-lg">Repetições</span>
          <div className="flex items-center gap-4">
            <button onClick={() => setReps(r => Math.max(0, r - 1))} className="w-12 h-12 bg-dark-700 text-white rounded-full text-2xl font-bold active:scale-95">-</button>
            <span className="text-3xl font-bold w-12 text-center text-white">{reps}</span>
            <button onClick={() => setReps(r => r + 1)} className="w-12 h-12 bg-dark-700 text-white rounded-full text-2xl font-bold active:scale-95">+</button>
          </div>
        </div>

        <div className="flex justify-between items-center bg-dark-800 p-5 rounded-2xl border border-dark-700 shadow-sm">
          <span className="text-gray-300 font-semibold text-lg">Carga (kg)</span>
          <div className="flex items-center gap-4">
             <button onClick={() => setWeight(w => Math.max(0, w - 1))} className="w-12 h-12 bg-dark-700 text-white rounded-full text-2xl font-bold active:scale-95">-</button>
             <span className="text-3xl font-bold w-12 text-center text-white">{weight}</span>
             <button onClick={() => setWeight(w => w + 1)} className="w-12 h-12 bg-dark-700 text-white rounded-full text-2xl font-bold active:scale-95">+</button>
          </div>
        </div>

        <div className="flex justify-between items-center bg-dark-800 p-5 rounded-2xl border border-dark-700 shadow-sm">
          <span className="text-gray-300 font-semibold text-lg">RIR <span className="text-xs font-normal text-gray-500 block">Rep na reserva</span></span>
          <select 
            value={rir} 
            onChange={(e) => setRir(Number(e.target.value))}
            className="bg-dark-700 text-white font-bold p-3 rounded-xl border-none outline-none w-24 text-center text-lg appearance-none"
          >
            {[0,1,2,3,4,5].map(v => <option key={v} value={v}>{v === 5 ? '5+' : v}</option>)}
          </select>
        </div>
      </div>

      <button 
        onClick={handleCompleteSet}
        className="w-full bg-brand-500 text-white font-bold py-5 rounded-2xl text-xl mt-6 active:scale-95 transition-transform"
      >
        CONCLUIR SÉRIE
      </button>
    </div>
  );
}