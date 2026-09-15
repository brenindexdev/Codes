import { useState } from 'react';
import { useLiveQuery } from 'dexie-react-hooks';
import { db } from '../database/db';
import { User, Dumbbell, Save, Plus, Activity, Edit2, Trash2 } from 'lucide-react';

export default function SettingsScreen() {
  const [activeTab, setActiveTab] = useState<'profile' | 'exercises'>('profile');
  const profile = useLiveQuery(() => db.userProfile.toCollection().first());
  const exercises = useLiveQuery(() => db.exercises.toArray());

  return (
    <div className="p-5 flex flex-col h-full bg-dark-900 text-white gap-4">
      <h1 className="text-2xl font-bold">Configurações</h1>
      
      {/* Abas */}
      <div className="flex bg-dark-800 rounded-xl p-1 border border-dark-700">
        <button onClick={() => setActiveTab('profile')} className={`flex-1 py-2 text-sm font-bold rounded-lg flex justify-center items-center gap-2 ${activeTab === 'profile' ? 'bg-brand-500 text-white' : 'text-gray-400'}`}><User size={16}/> Perfil & Corpo</button>
        <button onClick={() => setActiveTab('exercises')} className={`flex-1 py-2 text-sm font-bold rounded-lg flex justify-center items-center gap-2 ${activeTab === 'exercises' ? 'bg-brand-500 text-white' : 'text-gray-400'}`}><Dumbbell size={16}/> Exercícios</button>
      </div>

      <div className="flex-1 overflow-y-auto pb-10">
        {activeTab === 'profile' && profile && <ProfileSection profile={profile} />}
        {activeTab === 'exercises' && exercises && <ExercisesSection exercises={exercises} />}
      </div>
    </div>
  );
}

// ---- COMPONENTE DO PERFIL (MÉTRICAS E DIETA) ----
function ProfileSection({ profile }: { profile: any }) {
  const [form, setForm] = useState({
    currentWeight: profile.currentWeight,
    height: profile.height,
    age: profile.age,
    gender: profile.gender || 'M',
    activityLevel: profile.activityLevel || 1.2
  });

  const handleSave = async () => {
    await db.userProfile.update(profile.id, form);
    alert('Perfil atualizado com sucesso!');
  };

  // Cálculos Automáticos
  const heightInMeters = form.height / 100;
  const bmi = (form.currentWeight / (heightInMeters * heightInMeters)).toFixed(1);
  
  // Fórmula Mifflin-St Jeor para TMB (Taxa Metabólica Basal)
  const isMale = form.gender === 'M';
  const tmb = (10 * form.currentWeight) + (6.25 * form.height) - (5 * form.age) + (isMale ? 5 : -161);
  const tdee = Math.round(tmb * form.activityLevel); // Gasto calórico diário (Manutenção)

  return (
    <div className="flex flex-col gap-6 animate-fade-in">
      <div className="bg-dark-800 p-5 rounded-2xl border border-dark-700">
        <h2 className="text-brand-500 font-bold mb-4 flex items-center gap-2"><Activity size={20}/> Dados Corporais</h2>
        
        <div className="grid grid-cols-2 gap-4">
          <label className="flex flex-col text-sm text-gray-400">Peso (kg)
            <input type="number" value={form.currentWeight} onChange={e => setForm({...form, currentWeight: Number(e.target.value)})} className="mt-1 bg-dark-700 text-white p-3 rounded-xl outline-none" />
          </label>
          <label className="flex flex-col text-sm text-gray-400">Altura (cm)
            <input type="number" value={form.height} onChange={e => setForm({...form, height: Number(e.target.value)})} className="mt-1 bg-dark-700 text-white p-3 rounded-xl outline-none" />
          </label>
          <label className="flex flex-col text-sm text-gray-400">Idade
            <input type="number" value={form.age} onChange={e => setForm({...form, age: Number(e.target.value)})} className="mt-1 bg-dark-700 text-white p-3 rounded-xl outline-none" />
          </label>
          <label className="flex flex-col text-sm text-gray-400">Gênero biológico
            <select value={form.gender} onChange={e => setForm({...form, gender: e.target.value as 'M'|'F'})} className="mt-1 bg-dark-700 text-white p-3 rounded-xl outline-none appearance-none">
              <option value="M">Masculino</option>
              <option value="F">Feminino</option>
            </select>
          </label>
        </div>

        <label className="flex flex-col text-sm text-gray-400 mt-4">Nível de Atividade (Treino e Rotina)
          <select value={form.activityLevel} onChange={e => setForm({...form, activityLevel: Number(e.target.value)})} className="mt-1 bg-dark-700 text-white p-3 rounded-xl outline-none appearance-none">
            <option value={1.2}>Sedentário (Trabalho de mesa, pouco treino)</option>
            <option value={1.375}>Leve (Treino 1-3 dias/semana)</option>
            <option value={1.55}>Moderado (Treino 3-5 dias/semana)</option>
            <option value={1.725}>Intenso (Treino 6-7 dias/semana)</option>
          </select>
        </label>

        <button onClick={handleSave} className="w-full bg-brand-500 mt-6 text-white font-bold py-3 rounded-xl flex justify-center items-center gap-2 active:scale-95 transition-transform"><Save size={20}/> Salvar Dados</button>
      </div>

      {/* Cartão de Diagnóstico Metabólico */}
      <div className="bg-brand-900/30 p-5 rounded-2xl border border-brand-500/30 flex flex-col gap-3">
        <h2 className="text-brand-500 font-bold uppercase text-sm tracking-wider">Métricas & Dieta</h2>
        <div className="flex justify-between items-center border-b border-white/10 pb-2">
          <span className="text-gray-300">IMC (Índice de Massa Corporal)</span>
          <span className="font-bold text-lg">{bmi}</span>
        </div>
        <div className="flex justify-between items-center border-b border-white/10 pb-2">
          <span className="text-gray-300">Manutenção Calórica (TDEE)</span>
          <span className="font-bold text-lg text-green-400">{tdee} kcal</span>
        </div>
        <p className="text-xs text-gray-400 mt-2">
          Para <b>ganhar massa</b>, consuma ~{tdee + 300} kcal. Para <b>perder gordura</b> mantendo músculo, consuma ~{tdee - 300} kcal. Priorize proteínas (aprox. {Math.round(form.currentWeight * 1.8)}g/dia).
        </p>
      </div>
    </div>
  );
}

// ---- COMPONENTE DO DICIONÁRIO DE EXERCÍCIOS ----
function ExercisesSection({ exercises }: { exercises: any[] }) {
  const [showAddForm, setShowAddForm] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [newEx, setNewEx] = useState({ name: '', muscleGroup: 'Peito', equipment: 'Corporal', instructions: '' });

  const categories = ['Peito', 'Costas', 'Pernas', 'Ombros', 'Braços', 'Core', 'Cardio', 'Outros'];

  const openNewForm = () => {
    setEditingId(null);
    setNewEx({ name: '', muscleGroup: 'Peito', equipment: 'Corporal', instructions: '' });
    setShowAddForm(true);
  };

  const openEditForm = (ex: any) => {
    setEditingId(ex.id);
    setNewEx({ name: ex.name, muscleGroup: ex.muscleGroup || 'Outros', equipment: ex.equipment, instructions: ex.instructions });
    setShowAddForm(true);
  };

  const handleSave = async () => {
    if(!newEx.name) return;

    if (editingId) {
      await db.exercises.update(editingId, newEx);
    } else {
      await db.exercises.add(newEx);
    }
    
    setShowAddForm(false);
  };

  const handleDelete = async (id: number) => {
    if (!confirm('ATENÇÃO: Excluir este exercício o removerá de todos os treinos vinculados. Deseja continuar?')) return;

    await db.transaction('rw', db.exercises, db.workoutExercises, async () => {
      await db.workoutExercises.where('exerciseId').equals(id).delete();
      await db.exercises.delete(id);
    });
  };

  const groupedExercises = exercises.reduce((acc, ex) => {
    const group = ex.muscleGroup || 'Outros';
    if (!acc[group]) acc[group] = [];
    acc[group].push(ex);
    return acc;
  }, {} as Record<string, any[]>);

  return (
    <div className="flex flex-col gap-6 animate-fade-in">
      {!showAddForm ? (
        <button onClick={openNewForm} className="w-full bg-dark-700 text-brand-500 font-bold py-4 rounded-xl flex justify-center items-center gap-2 border border-brand-500 border-dashed active:bg-dark-600">
          <Plus size={20}/> Adicionar Novo Exercício
        </button>
      ) : (
        <div className="bg-dark-800 p-5 rounded-2xl border border-brand-500 animate-fade-in">
          <h3 className="font-bold mb-4">{editingId ? 'Editar Exercício' : 'Novo Exercício'}</h3>
          <div className="flex flex-col gap-3">
            <input placeholder="Nome do exercício" value={newEx.name} onChange={e => setNewEx({...newEx, name: e.target.value})} className="bg-dark-700 text-white p-3 rounded-xl outline-none" />
            <select value={newEx.muscleGroup} onChange={e => setNewEx({...newEx, muscleGroup: e.target.value})} className="bg-dark-700 text-white p-3 rounded-xl outline-none appearance-none">
              {categories.map(c => <option key={c} value={c}>{c}</option>)}
            </select>
            <input placeholder="Equipamento (Ex: Corporal, Barra)" value={newEx.equipment} onChange={e => setNewEx({...newEx, equipment: e.target.value})} className="bg-dark-700 text-white p-3 rounded-xl outline-none" />
            <textarea placeholder="Instruções de execução" value={newEx.instructions} onChange={e => setNewEx({...newEx, instructions: e.target.value})} className="bg-dark-700 text-white p-3 rounded-xl outline-none h-24" />
            <div className="flex gap-2 mt-2">
              <button onClick={() => setShowAddForm(false)} className="flex-1 bg-dark-700 text-white font-bold py-3 rounded-xl">Cancelar</button>
              <button onClick={handleSave} className="flex-1 bg-brand-500 text-white font-bold py-3 rounded-xl">Salvar</button>
            </div>
          </div>
        </div>
      )}

      {/* Lista Agrupada com Opções de Edição/Exclusão */}
      {categories.map(cat => {
        const list = groupedExercises[cat];
        if (!list || list.length === 0) return null;
        return (
          <div key={cat} className="bg-dark-800 rounded-2xl overflow-hidden border border-dark-700">
            <div className="bg-dark-700 px-4 py-2 font-bold text-sm text-brand-500 uppercase">{cat}</div>
            <div className="flex flex-col divide-y divide-dark-700/50">
              {list.map((ex: any) => (
                <div key={ex.id} className="p-4 flex justify-between items-center group">
                  <div className="flex-1 pr-2">
                    <p className="font-bold text-white">{ex.name}</p>
                    <p className="text-xs text-gray-400 mt-1">{ex.equipment} • {ex.instructions.substring(0, 50)}...</p>
                  </div>
                  <div className="flex gap-1 opacity-80">
                    <button onClick={() => openEditForm(ex)} className="p-3 bg-dark-700 rounded-lg text-blue-400 active:bg-dark-600"><Edit2 size={16}/></button>
                    <button onClick={() => handleDelete(ex.id!)} className="p-3 bg-dark-700 rounded-lg text-red-400 active:bg-dark-600"><Trash2 size={16}/></button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        );
      })}
    </div>
  );
}