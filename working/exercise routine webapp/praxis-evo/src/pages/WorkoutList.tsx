import { useState } from 'react';
import { useLiveQuery } from 'dexie-react-hooks';
import { db } from '../database/db';
import { Dumbbell, ChevronDown, ChevronUp, Edit2, Check, Trash2, Plus, X } from 'lucide-react';

export default function WorkoutListScreen() {
  const stages = useLiveQuery(() => db.stages.toArray());
  const [expandedStage, setExpandedStage] = useState<number | null>(null);
  
  // Controle de Edição de Estágios
  const [editingStage, setEditingStage] = useState<any>(null);
  const [isAddingStage, setIsAddingStage] = useState(false);
  const [stageForm, setStageForm] = useState({ name: '', startDate: '', endDate: '' });

  if (!stages) return <div className="p-5 text-gray-400">Carregando...</div>;

  const handleSaveStage = async () => {
    if (!stageForm.name) return;

    if (editingStage) {
      // Atualizar existente
      await db.stages.update(editingStage.id, {
        name: stageForm.name,
        startDate: stageForm.startDate,
        endDate: stageForm.endDate
      });
      setEditingStage(null);
    } else {
      // Adicionar novo estágio
      const nextOrder = stages.length > 0 ? Math.max(...stages.map(s => s.order)) + 1 : 1;
      const newStageId = await db.stages.add({
        name: stageForm.name,
        startDate: stageForm.startDate,
        endDate: stageForm.endDate,
        order: nextOrder
      });
      // Cria dias padrão para facilitar
      await db.workoutDays.bulkAdd([
        { stageId: newStageId, dayOfWeek: 3, name: 'SUPERIOR A', focus: 'Foco Superior' },
        { stageId: newStageId, dayOfWeek: 5, name: 'INFERIORES', focus: 'Foco Inferior' },
        { stageId: newStageId, dayOfWeek: 7, name: 'SUPERIOR B', focus: 'Foco Superior/Costas' }
      ]);
      setIsAddingStage(false);
    }
    setStageForm({ name: '', startDate: '', endDate: '' });
  };

  const handleDeleteStage = async (id: number) => {
    if (!confirm('ATENÇÃO: Excluir este estágio apagará todos os exercícios planejados para ele. Continuar?')) return;
    
    // Transação para apagar o Estágio e os Dias/Exercícios em Cascata
    const days = await db.workoutDays.where('stageId').equals(id).toArray();
    const dayIds = days.map(d => d.id!);
    
    await db.transaction('rw', db.stages, db.workoutDays, db.workoutExercises, async () => {
      await db.workoutExercises.where('workoutDayId').anyOf(dayIds).delete();
      await db.workoutDays.where('stageId').equals(id).delete();
      await db.stages.delete(id);
    });
  };

  return (
    <div className="p-5 flex flex-col h-full bg-dark-900 text-white gap-4">
      <h1 className="text-2xl font-bold mb-2">Editor de Rotinas</h1>
      
      {/* Formulário de Adicionar/Editar Estágio */}
      {(isAddingStage || editingStage) && (
        <div className="bg-dark-800 p-4 rounded-xl border border-brand-500 animate-fade-in mb-4">
          <h3 className="font-bold text-brand-500 mb-3">{editingStage ? 'Editar Estágio' : 'Novo Estágio'}</h3>
          <div className="flex flex-col gap-3">
            <input placeholder="Nome do Estágio (Ex: INICIANTE)" value={stageForm.name} onChange={e => setStageForm({...stageForm, name: e.target.value})} className="bg-dark-700 text-white p-3 rounded-lg outline-none" />
            <div className="grid grid-cols-2 gap-2">
              <label className="text-xs text-gray-400">Data Início
                <input type="date" value={stageForm.startDate} onChange={e => setStageForm({...stageForm, startDate: e.target.value})} className="w-full mt-1 bg-dark-700 text-white p-2 rounded-lg outline-none appearance-none" />
              </label>
              <label className="text-xs text-gray-400">Data Fim
                <input type="date" value={stageForm.endDate} onChange={e => setStageForm({...stageForm, endDate: e.target.value})} className="w-full mt-1 bg-dark-700 text-white p-2 rounded-lg outline-none appearance-none" />
              </label>
            </div>
            <div className="flex justify-end gap-2 mt-2">
              <button onClick={() => { setIsAddingStage(false); setEditingStage(null); }} className="px-4 py-3 bg-dark-700 rounded-lg font-bold flex-1">Cancelar</button>
              <button onClick={handleSaveStage} className="px-4 py-3 bg-brand-500 text-white rounded-lg font-bold flex-1">Salvar</button>
            </div>
          </div>
        </div>
      )}

      <div className="flex flex-col gap-4 pb-10">
        {stages.sort((a,b) => a.order - b.order).map(stage => (
          <div key={stage.id} className="bg-dark-800 rounded-2xl border border-dark-700 overflow-hidden">
            
            <div className="flex justify-between items-center p-2 border-b border-dark-700/50 bg-dark-900/30">
               <span className="text-xs text-gray-500 font-bold ml-2">ORDEM: {stage.order}</span>
               <div className="flex gap-2">
                 <button onClick={() => { setEditingStage(stage); setStageForm({ name: stage.name, startDate: stage.startDate, endDate: stage.endDate }); }} className="p-2 text-blue-400 active:bg-dark-700 rounded-lg"><Edit2 size={16}/></button>
                 <button onClick={() => handleDeleteStage(stage.id!)} className="p-2 text-red-400 active:bg-dark-700 rounded-lg"><Trash2 size={16}/></button>
               </div>
            </div>

            <button 
              onClick={() => setExpandedStage(expandedStage === stage.id ? null : stage.id!)}
              className="w-full flex justify-between items-center p-5 bg-dark-800 active:bg-dark-700 transition-colors"
            >
              <div className="text-left">
                <h2 className="font-black text-lg text-brand-500">{stage.name}</h2>
                <p className="text-xs text-gray-400">{stage.startDate} até {stage.endDate}</p>
              </div>
              {expandedStage === stage.id ? <ChevronUp className="text-brand-500"/> : <ChevronDown className="text-gray-500"/>}
            </button>

            {expandedStage === stage.id && (
              <div className="p-3 pt-0 border-t border-dark-700 bg-dark-900/50">
                <WorkoutDaysList stageId={stage.id!} />
              </div>
            )}
          </div>
        ))}

        {!isAddingStage && !editingStage && (
          <button onClick={() => { setIsAddingStage(true); setStageForm({ name: '', startDate: '', endDate: '' }); }} className="w-full py-4 border-2 border-dashed border-dark-700 text-gray-400 font-bold rounded-2xl flex justify-center items-center gap-2 active:bg-dark-800">
            <Plus size={20} /> Adicionar Nova Etapa
          </button>
        )}
      </div>
    </div>
  );
}

// ---- LISTA DE DIAS DO ESTÁGIO ----
function WorkoutDaysList({ stageId }: { stageId: number }) {
  const days = useLiveQuery(() => db.workoutDays.where('stageId').equals(stageId).toArray(), [stageId]);
  
  if (!days) return null;

  return (
    <div className="flex flex-col gap-3 mt-3">
      {days.map(day => (
        <div key={day.id} className="bg-dark-800 border border-dark-700 rounded-xl p-4">
          <h3 className="font-bold text-white mb-1 flex items-center gap-2"><Dumbbell size={16} className="text-brand-500"/> {day.name}</h3>
          <p className="text-xs text-gray-400 mb-4">Foco: {day.focus}</p>
          
          {/* Lista de Exercícios daquele Dia */}
          <ExerciseEditorList workoutDayId={day.id!} />
        </div>
      ))}
    </div>
  );
}

// ---- LISTA DE EXERCÍCIOS PARA EDIÇÃO RÁPIDA ----
function ExerciseEditorList({ workoutDayId }: { workoutDayId: number }) {
  // Puxa a relação de exercícios deste dia específico
  const workoutExercises = useLiveQuery(async () => {
    const we = await db.workoutExercises.where('workoutDayId').equals(workoutDayId).sortBy('order');
    return Promise.all(we.map(async (item) => {
      const details = await db.exercises.get(item.exerciseId);
      return { ...item, details };
    }));
  }, [workoutDayId]);

  const [editingId, setEditingId] = useState<number | null>(null);
  const [editForm, setEditForm] = useState({ sets: 3, minReps: 8, maxReps: 12, targetWeight: 0, restSeconds: 60 });

  if (!workoutExercises) return <div className="text-xs text-gray-500">Buscando exercícios...</div>;

  const startEdit = (item: any) => {
    setEditingId(item.id);
    setEditForm({ sets: item.sets, minReps: item.minReps, maxReps: item.maxReps, targetWeight: item.targetWeight, restSeconds: item.restSeconds });
  };

  const saveEdit = async () => {
    if (editingId) {
      await db.workoutExercises.update(editingId, editForm);
      setEditingId(null);
    }
  };

  return (
    <div className="flex flex-col gap-2">
      {workoutExercises.map(item => (
        <div key={item.id} className="bg-dark-900 p-3 rounded-lg border border-dark-700/50 flex flex-col gap-2">
          
          {/* Visualização Padrão */}
          {editingId !== item.id ? (
            <div className="flex justify-between items-center">
              <div>
                <p className="text-sm font-bold text-white">{item.order}. {item.details?.name}</p>
                <p className="text-xs text-gray-400 mt-0.5">
                  {item.sets} x {item.minReps}-{item.maxReps} reps • {item.targetWeight > 0 ? `${item.targetWeight}kg` : 'Corporal'} • {item.restSeconds}s desc.
                </p>
              </div>
              <button onClick={() => startEdit(item)} className="p-2 bg-dark-700 rounded-lg text-gray-400 active:text-brand-500">
                <Edit2 size={16} />
              </button>
            </div>
          ) : (
            /* Modo Edição Ativo */
            <div className="flex flex-col gap-3 animate-fade-in">
              <p className="text-sm font-bold text-brand-500 border-b border-dark-700 pb-2">Editando: {item.details?.name}</p>
              
              <div className="grid grid-cols-2 gap-3">
                <label className="text-xs text-gray-400">Séries
                  <input type="number" value={editForm.sets} onChange={e => setEditForm({...editForm, sets: Number(e.target.value)})} className="w-full mt-1 bg-dark-700 p-2 rounded outline-none text-white font-bold" />
                </label>
                <label className="text-xs text-gray-400">Carga (kg)
                  <input type="number" value={editForm.targetWeight} onChange={e => setEditForm({...editForm, targetWeight: Number(e.target.value)})} className="w-full mt-1 bg-dark-700 p-2 rounded outline-none text-white font-bold" />
                </label>
                <label className="text-xs text-gray-400">Min Reps
                  <input type="number" value={editForm.minReps} onChange={e => setEditForm({...editForm, minReps: Number(e.target.value)})} className="w-full mt-1 bg-dark-700 p-2 rounded outline-none text-white font-bold" />
                </label>
                <label className="text-xs text-gray-400">Max Reps
                  <input type="number" value={editForm.maxReps} onChange={e => setEditForm({...editForm, maxReps: Number(e.target.value)})} className="w-full mt-1 bg-dark-700 p-2 rounded outline-none text-white font-bold" />
                </label>
              </div>
              
              <div className="flex justify-end gap-2 mt-1">
                <button onClick={() => setEditingId(null)} className="px-4 py-2 text-xs font-bold bg-dark-700 rounded-lg">Cancelar</button>
                <button onClick={saveEdit} className="px-4 py-2 text-xs font-bold bg-green-600 text-white rounded-lg flex items-center gap-1"><Check size={14}/> Salvar</button>
              </div>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}