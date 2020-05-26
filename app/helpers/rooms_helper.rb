module RoomsHelper

	# s最新メッセージのデータを取得して表示するメソッド
	def most_nes_message_preview(room)
		# 最新メッセージの取得
		message = room.messages.order(updated_at: :desc).limit(1)
		# 配列から取り出す
		massage = message[0]
		# メッセージの有無を判定
		if message.present?
			# メッセージがあれば内容を表示
			tag.p "#{message.text}", class: "dm_list_content_link_box_message"
		else
			# メッセージが無い時の表示
			tag.p "[ メッセージはありません ]", class: "dm_list_content_link_box_message"
		end
	end

	# 相手のユーザー名を取得して表示するメソッド
	def opponent_user(room)
		#中間テーブルから相手のユーザーのデータを取得
		entry = room.entries.where.not(user_id: current_user)
		#相手ユーザーの名前を取得
		name = entry[0].user.name
		# 名前を表示
		tag.p "#{name}", class: "dm_list_content_link_box_name"
	end


end
