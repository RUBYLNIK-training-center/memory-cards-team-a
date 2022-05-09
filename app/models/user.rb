class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

#Database Authenticatable: предоставляет возможность входа в систему на основе зашифрованного и хранимого в базе данных пароля. Вход может быть выполнен посредством отправки POST-запроса или с помощью HTTP Basic Authentication.
# Omniauthable: добавляет поддержку Omniauth (github.com/intridea/omniauth).
# Confirmable: позволяет отправлять письмо с инструкциями для подтверждения аккаунта, созданного во время регистрации.
# Recoverable: позволяет восстанавливать забытый пароль. Отправляет инструкции по восстановлению на почту.
# Registerable: управляет регистрацией пользователей, позволяет редактировать и удалять аккаунты.
# Rememberable: позволяет запоминать пользователей на основе cookies. Управляет созданием и удалением токенов.
# Trackable: ведет статистику количества входов, учитывает время и IT-адреса.
# Timeoutable: отвечает за продолжительность сессии активности пользователя в системе.
# Validatable: предоставляет инструменты валидации e-mail и пароля. Модуль может быть легко настроен, вы можете определить собственные валидаторы.
# Lockable: блокирует аккаунт после указанного в настройках количество неудачных попыток авторизации. Аккаунт может быть разблокирован посредством email или через определенный период времени.
