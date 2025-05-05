-- Expresiones Lambda
-- Mecanismo para definir una función in situ.
-- No usar si la misma expresión lambda se repite para evitar repetición de lógica.
-- No usar si hay un buen nombre para la lógica que abstrae porque baja expresividad + declaratividad.

doble unNumero = unNumero * 2
-- \unNumero   -> unNumero * 2

-- Currificación
-- Proceso de convertir una funcion de N (> 1) parámetros en una cadena de N funciones de 1 parámetro.
-- Haskell lo hace automáticamente sin que hagamos nada.
-- Aplicación parcial es consecuencia de la currificación.

unaFuncionReLoca :: [Int] -> [Int]
unaFuncionReLoca enteros = map (\unEntero -> unEntero ^ unEntero) enteros

sumaDe3 :: Int -> Int -> Int -> Int
sumaDe3 numero1 numero2 numero3 = numero1 + numero2 + numero3

sumaDe3' :: (Int -> Int -> Int -> Int)
sumaDe3' = \numero1 numero2 numero3 -> numero1 + numero2 + numero3

sumaDe3'' :: (Int -> (Int -> Int -> Int))
sumaDe3'' = \numero1 -> \numero2 numero3 -> numero1 + numero2 + numero3

sumaDe3''' :: (Int -> (Int -> (Int -> Int)))
sumaDe3''' = \numero1 -> \numero2 -> \numero3 -> numero1 + numero2 + numero3

pi :: Float
pi = 3.1415926535897932384626

-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- (.) f g = \x -> f (g x)

-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- (.) f g x = f (g x)

-- Recursividad
-- Una función puede llamarse a sí misma.
-- Usualmente se divide en uno o más casos base y un caso recursivo.

factorial :: Int -> Int
factorial unNumero
  | unNumero > 1 = (* unNumero) . factorial . (subtract 1) $ unNumero
  | otherwise    = 1

factorial' 0 = 1                                           -- Caso base
factorial' unNumero = unNumero * factorial' (unNumero - 1) -- Caso recursivo

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci unNumero = fibonacci (unNumero - 1) + fibonacci (unNumero - 2)

-- Patrones de listas
-- []               - Matchea con la lista vacía
-- [x]              - Matchea con una lista que tiene un sólo elemento
-- [x, y]           - Matchea con una lista que tiene un sólo dos elementos
-- (cabeza : cola)  - Matchea con una lista de N (>= 1) elementos, y la descompone en cabeza y cola

cabeza :: [a] -> a
cabeza (unValor : _) = unValor

cola :: [a] -> [a]
cola (_ : otrosValores) = otrosValores

sumatoria :: Num a => [a] -> a                                      --
sumatoria [] = 0                                                    --
sumatoria (cabeza : cola) = cabeza + sumatoria cola                 --
                                                                    --
productoria :: Num a => [a] -> a                                    --
productoria [] = 1                                                  --
productoria (cabeza : cola) = cabeza * productoria cola             --
                                                                    --  Lógica repetida
conjuncionatoria :: [Bool] -> Bool                                  --
conjuncionatoria [] = True                                          --
conjuncionatoria (cabeza : cola) = cabeza && conjuncionatoria cola  --
                                                                    --
disyuncionatoria :: [Bool] -> Bool                                  --
disyuncionatoria [] = False                                         --
disyuncionatoria (cabeza : cola) = cabeza || disyuncionatoria cola  --


-- Fold
-- Función de orden superior que abstrae la recursividad

sumatoria' :: Num a => [a] -> a
sumatoria' unaListaDeNumeros = foldr' (+) 0 unaListaDeNumeros

productoria' :: Num a => [a] -> a
productoria' unaListaDeNumeros = foldr' (*) 1 unaListaDeNumeros

conjuncionatoria' :: [Bool] -> Bool
conjuncionatoria' unaListaDeBooleanos = foldr' (&&) True unaListaDeBooleanos

disyuncionatoria' :: [Bool] -> Bool
disyuncionatoria' unaListaDeBooleanos = foldr' (||) False unaListaDeBooleanos

-- foldr' :: (a -> a -> a) -> a -> [a] -> a
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ casoBase [] = casoBase
foldr' operador casoBase (cabeza : cola) = cabeza `operador` (foldr' operador casoBase cola)

any unaCondicion unaLista = foldr' (\unValor semilla -> unaCondicion unValor || semilla) False unaLista
