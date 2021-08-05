class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true


  # То есть для анонимных пользователей
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  # Для конкретного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  # Или один email может использоваться только один раз (если анонимная подписка)
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  # Пользователь не может подписаться на своё событие (id)
  validate :event_owner_verification, if: -> { user.present? }

  # При подписке нельзя использовать почту зарегистрированных пользователей
  validate :email_is_not_taken, unless: -> { user.present? }

  # Почта незарегистрированных подписчиков на события сохраняется также в нижнем регистре
  before_save :downcase_email

  # Если есть юзер, выдаем его имя,
  # если нет – дергаем исходный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # Если есть юзер, выдаем его email,
  # если нет – дергаем исходный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def event_owner_verification
    errors.add(:user, :cannot_be_subscribed)  if user == event.user
  end

  def email_is_not_taken
    errors.add(:user_email, :email_is_already_taken) if User.exists?(email: user_email)
  end

  def downcase_email
    user_email.downcase!
  end
end
