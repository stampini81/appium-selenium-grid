Dado('que a Calculadora está aberta') do
  # A inicialização já abre a calculadora
end

Quando('eu pressiono {string}') do |tecla|
  driver.find_element(:name, tecla).click
end

Quando('eu pressiono +') do
  driver.find_element(:name, 'Mais').click
end

Quando('eu pressiono =') do
  driver.find_element(:name, 'Igual a').click
end

Então('o resultado deve ser {int}') do |valor|
  resultado = driver.find_element(:accessibility_id, 'CalculatorResults').text
  expect(resultado).to include(valor.to_s)
end
