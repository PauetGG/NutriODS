import {
  LayoutDashboardIcon,
  CalendarIcon,
  TrendingUpIcon,
  HeartPulseIcon,
  PieChartIcon,
} from 'lucide-react'
import { Link, useLocation, useParams } from 'react-router-dom'

type SidebarItemProps = {
  icon: React.ReactNode
  text: string
  to: string
}

export const Sidebar = () => {
  const { dietaId } = useParams()

  return (
    <div className="w-[160px] min-h-screen bg-white border-r border-gray-200 flex flex-col">
      <div className="p-4">
        <SidebarItem
          icon={<LayoutDashboardIcon size={18} />}
          text="Dashboard"
          to={`/seguimiento/${dietaId}/dashboard`}
        />
        <SidebarItem
          icon={<CalendarIcon size={18} />}
          text="Calendario"
          to={`/seguimiento/${dietaId}/calendar`}
        />
        <SidebarItem
          icon={<TrendingUpIcon size={18} />}
          text="Progreso"
          to={`/seguimiento/${dietaId}/progreso`}
        />
        <SidebarItem
          icon={<HeartPulseIcon size={18} />}
          text="Hábitos"
          to={`/seguimiento/${dietaId}/habitos`}
        />
        <SidebarItem
          icon={<PieChartIcon size={18} />}
          text="Estadísticas"
          to={`/seguimiento/${dietaId}/estadisticas`}
        />
      </div>
    </div>
  )
}

const SidebarItem = ({ icon, text, to }: SidebarItemProps) => {
  const location = useLocation()
  const isActive = location.pathname === to

  return (
    <Link
      to={to}
      className={`flex items-center py-2 px-3 rounded-md text-sm ${
        isActive
          ? 'text-blue-600 bg-blue-50 border-l-2 border-blue-600'
          : 'text-gray-700 hover:bg-gray-100'
      }`}
    >
      <span className="mr-2">{icon}</span>
      <span>{text}</span>
    </Link>
  )
}
