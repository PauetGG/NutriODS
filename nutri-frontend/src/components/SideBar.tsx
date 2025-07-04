import {
  HomeIcon,
  UsersIcon,
  BriefcaseIcon,
  DollarSignIcon,
  SettingsIcon,
  PuzzleIcon,
  LifeBuoyIcon,
  ChevronDownIcon,
} from 'lucide-react'

type SidebarItemProps = {
  icon: React.ReactNode
  text: string
}

type SubmenuItem = {
  text: string
  active: boolean
}

type SidebarItemWithSubmenuProps = {
  icon: React.ReactNode
  text: string
  isOpen: boolean
  submenuItems: SubmenuItem[]
}

export const Sidebar = () => {
  return (
    <div className="w-[160px] min-h-screen bg-white border-r border-gray-200 flex flex-col">
      <div className="p-4">
        <SidebarItem icon={<HomeIcon size={18} />} text="Dashboard" />
        <SidebarItemWithSubmenu
          icon={<UsersIcon size={18} />}
          text="Teams"
          isOpen={true}
          submenuItems={[
            { text: 'Employee', active: false },
            { text: 'Attendance', active: false },
            { text: 'Checklist', active: false },
            { text: 'Time off', active: true },
          ]}
        />
        <SidebarItemWithSubmenu
          icon={<BriefcaseIcon size={18} />}
          text="Hire"
          isOpen={false}
          submenuItems={[
            { text: 'Hiring', active: false },
            { text: 'Onboarding', active: false },
            { text: 'Hiring handbook', active: false },
          ]}
        />
        <SidebarItemWithSubmenu
          icon={<DollarSignIcon size={18} />}
          text="Finance"
          isOpen={false}
          submenuItems={[
            { text: 'Payroll', active: false },
            { text: 'Expenses', active: false },
            { text: 'Incentives', active: false },
            { text: 'Payment information', active: false },
          ]}
        />
        <SidebarItem icon={<SettingsIcon size={18} />} text="Settings" />
        <SidebarItem icon={<PuzzleIcon size={18} />} text="Integrations" />
        <SidebarItem icon={<LifeBuoyIcon size={18} />} text="Help and support" />
      </div>
      <div className="mt-auto p-4 border-t border-gray-200">
        <div className="flex items-center">
          <div className="w-8 h-8 rounded-md bg-blue-600 text-white flex items-center justify-center text-sm font-medium">
            WB
          </div>
          <div className="ml-2">
            <div className="text-sm font-medium">Wishbone</div>
            <div className="text-xs text-gray-500">61 members</div>
          </div>
          <ChevronDownIcon size={16} className="ml-auto text-gray-400" />
        </div>
      </div>
    </div>
  )
}

const SidebarItem = ({ icon, text }: SidebarItemProps) => {
  return (
    <div className="flex items-center py-2 px-3 rounded-md text-gray-700 hover:bg-gray-100 cursor-pointer">
      <span className="mr-2">{icon}</span>
      <span className="text-sm">{text}</span>
    </div>
  )
}

const SidebarItemWithSubmenu = ({
  icon,
  text,
  isOpen,
  submenuItems,
}: SidebarItemWithSubmenuProps) => {
  return (
    <div>
      <div className="flex items-center justify-between py-2 px-3 rounded-md text-gray-700 hover:bg-gray-100 cursor-pointer">
        <div className="flex items-center">
          <span className="mr-2">{icon}</span>
          <span className="text-sm">{text}</span>
        </div>
        <ChevronDownIcon size={16} className="text-gray-400" />
      </div>
      {isOpen && (
        <div className="ml-6 mt-1">
          {submenuItems.map((item: SubmenuItem, index: number) => (
            <div
              key={index}
              className={`py-1.5 px-3 text-sm rounded-md ${
                item.active
                  ? 'text-blue-600 bg-blue-50 border-l-2 border-blue-600'
                  : 'text-gray-700 hover:bg-gray-100'
              }`}
            >
              {item.text}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
