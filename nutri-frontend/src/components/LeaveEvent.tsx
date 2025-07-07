import { Smile, Calendar, User, Flag } from 'lucide-react'

type LeaveEventProps = {
  type: 'sick' | 'annual' | 'personal' | 'national' | string
  text: string
  count?: number
}

export const LeaveEvent = ({ type, text, count }: LeaveEventProps) => {
  const getEventStyles = () => {
    switch (type) {
      case 'sick':
        return {
          bgColor: 'bg-yellow-50',
          textColor: 'text-yellow-800',
          icon: <Smile size={14} className="text-yellow-600" />,
        }
      case 'annual':
        return {
          bgColor: 'bg-orange-50',
          textColor: 'text-orange-800',
          icon: <Calendar size={14} className="text-orange-600" />,
        }
      case 'personal':
        return {
          bgColor: 'bg-blue-50',
          textColor: 'text-blue-800',
          icon: <User size={14} className="text-blue-600" />,
        }
      case 'national':
        return {
          bgColor: 'bg-gray-50',
          textColor: 'text-gray-800',
          icon: <Flag size={14} className="text-gray-600" />,
        }
      default:
        return {
          bgColor: 'bg-gray-50',
          textColor: 'text-gray-800',
          icon: <Calendar size={14} className="text-gray-600" />,
        }
    }
  }

  const { bgColor, textColor, icon } = getEventStyles()

  return (
    <div className={`flex items-center p-1 rounded text-xs ${bgColor} ${textColor}`}>
      <span className="mr-1">{icon}</span>
      <span className="mr-1">{text}</span>
      {count !== undefined && <span className="ml-auto font-medium">{count}</span>}
    </div>
  )
}
