import { useLiveQuery } from 'dexie-react-hooks';
import { db } from '../database/db';
import { useNavigate } from 'react-router-dom';

export default function Home() {
  const navigate = useNavigate();
  const profile = useLiveQuery(() => db.userProfile.toCollection().first());
  const stages = useLiveQuery(() => db.stages.toArray());
  const workoutDays = useLiveQuery(() => db.workoutDays.where('stageId').equals(1).toArray());

  const todayDay = workoutDays?.[0]; 

  if (!profile || !stages || !todayDay) return <div className="p-6">Carregando...</div>;

  return (
    <div className="p-5 flex flex-col h-full gap-6">
      <header>
        <h1 className="text-2xl font-bold text-white">Treino de Hoje</h1>
        <p className="text-gray-400">Estágio Atual: <span className="text-brand-500 font-bold">{stages[0].name}</span></p>
      </header>

      <div className="bg-dark-800 rounded-2xl p-6 border border-dark-700 flex flex-col gap-4">
        <div>
          <h2 className="text-xl font-black uppercase text-brand-500">{todayDay.name}</h2>
          <p className="text-sm text-gray-400 mt-1">Foco: {todayDay.focus}</p>
        </div>
        
        <div className="bg-dark-900 rounded-lg p-4">
          <p className="text-xs text-gray-500 uppercase">Duração estimada</p>
          <p className="text-lg font-bold text-white">35–45 min</p>
        </div>

        <button 
          onClick={() => navigate(`/workout/run/${todayDay.id}`)}
          className="w-full bg-brand-500 text-white font-bold py-4 rounded-xl text-lg mt-2 active:bg-brand-900 transition-colors"
        >
          COMEÇAR TREINO
        </button>
      </div>

      <div className="bg-dark-800 rounded-xl p-4 text-sm text-gray-400 border border-dark-700">
        Este aplicativo é uma ferramenta de acompanhamento e não substitui orientação profissional.
      </div>
    </div>
  );
}