def AheGaoDoublePeace(text)
    str = text
    str = str.gsub(/(気持|きも)ちいい/,'ぎも゛ぢい゛い゛ぃ')
    str = str.gsub(/(大好|だいす)き/,'らいしゅきいぃっ')
    str = str.gsub(/(ミルク|みるく|牛乳)/,'ちんぽミルク')
    str = str.gsub(/お(願|ねが)い/,'お願いぃぃぃっっっﾞ')
    str = str.gsub(/ぁ/,'ぁぁ゛ぁ゛')
    str = str.gsub(/あ/,'ぁあああ あぉ')
    str = str.gsub(/お/,'おﾞぉおォおん')
    str = str.gsub(/ごきげんよう/,'ごきげんよぉおお！んおっ！んおおーーっ！ ')
    str = str.gsub(/ごきげんよう/,'ごきげんみゃぁあ゛あ゛ぁ゛ぁぁあ！！')
    str = str.gsub(/こん(にち|ばん)[はわ]/){'こん' + $1 + 'みゃぁあ゛あ゛ぁ゛ぁぁあ！！'}
    str = str.gsub(/えて/,'えてへぇええぇﾞ')
    str = str.gsub(/する/,'するの')
    str = str.gsub(/します/,'するの')
    str = str.gsub(/精液/,'せーしっせーし でりゅぅ でちゃいましゅ みるく ちんぽみるく ふたなりみるく')
    str = str.gsub(/射精/,'でちゃうっ れちゃうよぉおおﾞ')
    str = str.gsub(/(馬鹿|バカ|ばか)/,'バカ！バカ！まんこ!!')
    str = str.gsub(/いい/,'いぃぃっよぉおおﾞ')
    str = str.gsub(/[好す]き/,'ちゅき')
    str = str.gsub(/して/,'してぇぇぇぇ゛')
    str = str.gsub(/行く/,'んはっ イっぐぅぅぅふうぅ')
    str = str.gsub(/いく/,'イっくぅぅふぅん')
    str = str.gsub(/イク/,'イッちゃううぅん')
    str = str.gsub(/駄目/,'らめにゃのぉぉぉ゛')
    str = str.gsub(/ダメ/,'んぉほぉぉォォ　らめぇ')
    str = str.gsub(/だめ/,'らめぇぇ')
    str = str.gsub(/ちゃん/,'ちゃぁん')
    str = str.gsub(/(おい|美味)しい/){$1 + 'ひぃ…れしゅぅ'}
    str = str.gsub(/(た|る|ない)([。、　 ・…!?！？」\n\r\x00])/){$1 + 'の' + $2}
    str = str.gsub(/さい([。、　 ・…!?！？」\n\r\x00])/){'さいなの' + $1}
    str = str.gsub(/よ([。、　 ・…!?！？」\n\r\x00])/){'よお゛お゛お゛ぉ' + $1}
    str = str.gsub(/もう/,'んもぉ゛お゛お゛ぉぉ')
    str = str.gsub(/(い|入)れて/,'いれてえぇぇぇえ')
    str = str.gsub(/(気持|きも)ちいい/,'きも゛ぢい゛～っ')
    str = str.gsub(/(がんば|頑張)る/){'尻穴ちんぽしごき' + $1 + 'るぅ!!!'}
    str = str.gsub(/出る/,'でちゃうっ れちゃうよぉおおﾞ')
    str = str.gsub(/でる/,'でっ…でるぅでるうぅうぅ')
    str = str.gsub(/です/,'れしゅぅぅぅ')
    str = str.gsub(/ます/,'ましゅぅぅぅ')
    str = str.gsub(/はい/,'はひぃ')
    str = str.gsub(/スゴイ/,'スゴぉッ!!')
    str = str.gsub(/(すご|凄)い/,'しゅごいのょぉぉぅ')
    str = str.gsub(/だ/,'ら')
    str = str.gsub(/さ/,'しゃ')
    str = str.gsub(/な/,'にゃ')
    str = str.gsub(/つ/,'ちゅ')
    str = str.gsub(/ちゃ/,'ひゃ')
    str = str.gsub(/じゃ/,'に゛ゃ')
    str = str.gsub(/ほ/,'ほお゛お゛っ')
    str = str.gsub(/で/,'れ')
    str = str.gsub(/す/,'しゅ')
    str = str.gsub(/ざ/,'じゃ')
    str = str.gsub(/い/,'いぃ')
    str = str.gsub(/の/,'のぉおお')
    return str
end

Plugin.create :mikutter_misakura do
    #みさくら語に変換して投稿する
    command(:misakura_nankotsu,
        name: 'みさくら語変換',
        condition: lambda{ |opt| true },
        visible: true,
        role: :postbox
    ) do |opt|
        begin
            Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text = AheGaoDoublePeace(Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text)
        end
    end

    #TL上のすべての文章をみさくら語に変換
    module Pango
        class << self
            alias parse_markup_org parse_markup

            def parse_markup(text)
                misakura_text = text
                if UserConfig[:translate_misakura]
                    misakura_text = AheGaoDoublePeace(text)
                end
                parse_markup_org(misakura_text)
            end
        end
    end

    #設定
    settings("みさくら語変換") do
        boolean("TL上のすべての文章をみさくら語に変換",:translate_misakura)
    end
end
