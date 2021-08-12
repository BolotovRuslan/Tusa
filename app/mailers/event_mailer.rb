# Письма о событиях
class EventMailer < ApplicationMailer
  # Письмо о новой подписке для автора события. В параметрах передаём то что необходимо
  # для составления текста письма.
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    # Метод формирует письмо: to: - на какой email отправляется письмо, др. поля - на выбор.
    # (subject:, from:, )
    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  # Письмо о новом комментарии на заданный email
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end
end