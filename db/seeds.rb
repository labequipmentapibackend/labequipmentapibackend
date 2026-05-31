# [cite: 31, 32]
MaintenanceRecord.destroy_all
Equipment.destroy_all
Category.destroy_all

computing = Category.create!(name: "Computing")
optics = Category.create!(name: "Optics")
networking = Category.create!(name: "Networking")
electronics = Category.create!(name: "Electronics")

eq1 = Equipment.create!(name: "Dell XPS", serial_number: "LAP-001", status: "available", category: computing)
eq2 = Equipment.create!(name: "MacBook Pro", serial_number: "LAP-002", status: "in_use", category: computing)
eq3 = Equipment.create!(name: "Electron Microscope", serial_number: "MIC-042", status: "maintenance", category: optics)
eq4 = Equipment.create!(name: "Hand Lens", serial_number: "OPT-001", status: "available", category: optics)
eq5 = Equipment.create!(name: "Cisco Router", serial_number: "ROU-101", status: "in_use", category: networking)
eq6 = Equipment.create!(name: "Netgear Switch", serial_number: "SWI-202", status: "available", category: networking)
eq7 = Equipment.create!(name: "Arduino Uno", serial_number: "ARD-999", status: "available", category: electronics)
eq8 = Equipment.create!(name: "Multimeter", serial_number: "MUL-005", status: "available", category: electronics)

MaintenanceRecord.create!(description: "Screen replacement", performed_at: 2.days.ago, equipment: eq1)
MaintenanceRecord.create!(description: "Lens calibration", performed_at: 1.week.ago, equipment: eq3)
MaintenanceRecord.create!(description: "Firmware update", performed_at: 3.days.ago, equipment: eq5)
MaintenanceRecord.create!(description: "Port cleaning", performed_at: 1.day.ago, equipment: eq5)
MaintenanceRecord.create!(description: "Battery replacement", performed_at: 1.month.ago, equipment: eq8)
# eq2, eq4, eq6, eq7 have NO maintenance records [cite: 31]