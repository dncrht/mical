h = File.open "/home/dani/Pasatiempos/python progs/yCal/efemerides.csv", 'r'
h.each_line do |l|
      dia, actividad_id, resumen = l.split "\t"
      e = Efemeride.new #TODO ¿no funciona .create?
      e.dia = dia
      e.actividad_id = actividad_id
      e.resumen = resumen
      e.save
end
h.close
