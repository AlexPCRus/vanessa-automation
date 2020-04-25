# language: ru
# encoding: utf-8
#parent uf:
@UF6_текстовые_и_видео_инструкции
#parent ua:
@UA41_формировать_текстовые_инструкции

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOn836
@IgnoreOn837
@IgnoreOn838
@IgnoreOn839
@IgnoreOnWeb



Функционал: Гарантированная установка компоненты 1cWinCtrl




	

Сценарий: Гарантированная установка компоненты 1cWinCtrl
	И я закрываю сеанс TESTCLIENT
	И Я запоминаю значение выражения 'ИмяПользователя()' в переменную "ИмяПользователя"
	Если 'Объект.ВерсияПоставки = "standart"' тогда
		Когда Я подключаю клиент тестирования с параметрами:
			| 'Имя'             |   'Логин'             | 'Запускаемая обработка'                        |
			| 'ЭтотКлиент'      |   '$ИмяПользователя$' | '$КаталогИнструментов$/vanessa-automation.epf' |
	Иначе			
		Когда Я подключаю клиент тестирования с параметрами:
			| 'Имя'             |   'Логин'             | 'Запускаемая обработка'                               |
			| 'ЭтотКлиент'      |   '$ИмяПользователя$' | '$КаталогИнструментов$/vanessa-automation-single.epf' |

	Тогда открылось окно '*Vanessa Automation*'
	И я перехожу к закладке с именем "ГруппаНастройки"
	И я перехожу к закладке с именем "СтраницаСкриншоты"
	И я устанавливаю флаг с именем 'ИспользоватьКомпоненту1cWinCtrl1'
	И пауза 5
	Если появилось предупреждение тогда
		Тогда я нажимаю на кнопку 'OK'

	
