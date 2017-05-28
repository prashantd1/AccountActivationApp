module ApplicationHelper

	def full_title(title = '')
		sub_title = "sample_mail_app"

		if title.empty?
			sub_title
		else
			"#{title} #{sub_title}"
		end
	end
end
