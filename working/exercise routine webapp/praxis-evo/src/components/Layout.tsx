import { Outlet, NavLink, useLocation } from 'react-router-dom';
import { Home, Dumbbell, Calendar, LineChart, Settings } from 'lucide-react';

export default function Layout() {
  const location = useLocation();
  const isWorkoutActive = location.pathname.includes('/workout/run');

  return (
    <div className="flex flex-col h-screen bg-dark-900 text-white font-sans overflow-hidden">
      <main className="flex-1 overflow-y-auto pb-20">
        <Outlet />
      </main>
      
      {!isWorkoutActive && (
        <nav className="fixed bottom-0 w-full bg-dark-800 border-t border-dark-700 flex justify-around p-3 pb-safe z-50">
          <NavItem to="/" icon={<Home />} label="Início" />
          <NavItem to="/workout" icon={<Dumbbell />} label="Treino" />
          <NavItem to="/calendar" icon={<Calendar />} label="Calendário" />
          <NavItem to="/progress" icon={<LineChart />} label="Progresso" />
          <NavItem to="/settings" icon={<Settings />} label="Config" />
        </nav>
      )}
    </div>
  );
}

function NavItem({ to, icon, label }: { to: string, icon: React.ReactNode, label: string }) {
  return (
    <NavLink to={to} className={({ isActive }) => `flex flex-col items-center gap-1 ${isActive ? 'text-brand-500' : 'text-gray-400'}`}>
      {icon}
      <span className="text-[10px] uppercase font-semibold">{label}</span>
    </NavLink>
  );
}