ActiveSupport::Inflector.inflections.clear #borra las inflexiones existentes

ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /([aeiou])([A-Z]|_|$)/, '\1s\2'
  inflect.plural /([^aeiou])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /([aeiou])([A-Z]|_|$)([a-z]+)([^aeiou])($)/, '\1s\2\3\4es\5'
  inflect.plural /([^aeiou])([A-Z]|_|$)([a-z]+)([aeiou])($)/, '\1es\2\3\4s\5'
  inflect.singular /([aeiou])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([^aeiou])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /([aeiou])s([A-Z]|_)([a-z]+)([^aeiou])es($)/, '\1\2\3\4\5'
  inflect.singular /([^aeiou])es([A-Z]|_)([a-z]+)([aeiou])s($)/, '\1\2\3\4\5'
  inflect.irregular 'carnet', 'carnets'
  inflect.irregular 'blog', 'blogs'
  inflect.irregular 'sede', 'sedes'
  inflect.irregular 'faq', 'faqs'
  inflect.irregular 'centro_formacion', 'centros_formacion'
  inflect.irregular 'categoria_competencia', 'categoria_competencias'
  inflect.irregular 'empresa_sede', 'empresas_sedes'
end
