import { useEffect } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import WorkoutActive from './pages/WorkoutActive';
import WorkoutList from './pages/WorkoutList';
import Settings from './pages/Settings';
import { seedDatabase } from './database/seed';

// Placeholders para as telas secundárias (podem ser movidos para src/pages/ depois)
const Calendar = () => <div className="p-6 text-white"><h1 className="text-2xl font-bold mb-4">Calendário</h1><p className="text-gray-400">Em breve: Visão mensal dos treinos.</p></div>;
const Progress = () => <div className="p-6 text-white"><h1 className="text-2xl font-bold mb-4">Progresso</h1><p className="text-gray-400">Em breve: Gráficos de volume e carga.</p></div>;

export default function App() {
  useEffect(() => {
    // Executa no primeiro load da aplicação
    seedDatabase().catch(console.error);
  }, []);

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="workout" element={<WorkoutList />} />
          <Route path="calendar" element={<Calendar />} />
          <Route path="progress" element={<Progress />} />
          <Route path="settings" element={<Settings />} />
        </Route>
        
        {/* Rota do Treino Ativo fica fora do Layout padrão para esconder a navegação inferior (Mobile App Feel) */}
        <Route path="/workout/run/:dayId" element={<WorkoutActive />} />
      </Routes>
    </BrowserRouter>
  );
}