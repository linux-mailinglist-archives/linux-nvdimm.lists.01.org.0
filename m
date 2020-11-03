Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B179C2A4D7E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 18:52:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB30C163D018C;
	Tue,  3 Nov 2020 09:52:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.176; helo=cha1.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha1.chairmaneventsummit.info (ip176.ip-54-38-202.eu [54.38.202.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA2EA15CEE860
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=PqbpB5gzhR238uA0zeBh1baS1lY=;
 b=LAs6MZVEj9qWLK8Yp5Zn59rTUoOcc4GLs40aZm3JdhazhNmlmpZYjH2GAMH57dZjTg2P5XtLBx5o
   HSFzK7+cVhhmyspDh/8ILLNYv7acn1wUmu6CrgzTen8NTa7KI9LZq0sFDb9kY8o9xfda6UHic1wR
   8KPtBUFhnB37LiTwOlQJY5f0YDy1ixly7sMY+bxt/HxT4OBOGLkJuPjO/i986fOKMKwQyfX/IG71
   OB3Y5EPC2SvGGhIefidldAe42NBHgdKEWfLa3ztyiE3g8xCahDqc44bq07fWuQ5wacE1ZVx664DU
   QRokBWRzSpRdrZhfdyHQcc5jG4qk1XWWfA6J4A==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=HZPha/DH6z8lGGe0Uh9XUAzAuuCsRA4jlOw+ldJr/4H8/sNeaxOpBmEekD2XsUUKsAGVG1abs5Sy
   SSNQwbl33Ixc8fjZLJqTf3tvsDg11GUyOIz+QArBWDkf3sbALgW2Mxb6lNlvGfas+LGWPkv+YAre
   ZJCssPua2CyVj7V9TJQZXWd8I4ifn97pTRmdH5O6CD8gIEJanvDFXoEfC2EThtq6+Wt5FrOuAaMO
   Pe4oQ2BA9+4mNvnpl/d7XN4ZmcZsCMFJ5/a0WOj1+xFfH+SNhEQWa3/N1IMHKmHz2y0GBj+zOY66
   Zd1mBSi+VWkwU3/9P0TkvzJ5BsSqGrCasWHWAg==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hk6cdfi19tku for <linux-nvdimm@lists.01.org>; Tue, 3 Nov 2020 17:52:19 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Tue, 3 Nov 2020 17:52:19 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Garcia Taylor <info@chairmaneventsummit.info>
Subject: RE: 10K LinkedIn Leads at 500
Message-ID: <9029fd0b3148f95bd09cd512592ec32c@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: jm7712913v85c
X-Trgm-Subscriber-Uid: xj9408r1qtf27
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/jm7712913v85c/report-abuse/tr3842wxgefa2/xj9408r1qtf27
Feedback-ID: jm7712913v85c:xj9408r1qtf27:tr3842wxgefa2:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: 2RXOFCBXZUP655JODWLAREJNER6JNJAK
X-Message-ID-Hash: 2RXOFCBXZUP655JODWLAREJNER6JNJAK
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Garcia Taylor <garcia@soltecmaredm.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2RXOFCBXZUP655JODWLAREJNER6JNJAK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIDEwMCUgYWNjdXJhdGUgMTAsMDAwIFRhcmdl
dGVkIExlYWRzDQpmcm9tIExpbmtlZEluIGF0ICQ1MDAoQW55IHRpdGxlcy9pbmR1c3RyeS9sb2Nh
dGlvbi9rZXl3b3Jkcyk/DQpJZiB5b3UgaGF2ZSBhIHZlcnkgdGFyZ2V0ZWQgZGF0YSByZXF1aXJl
bWVudCBhbmQgeW91IG5lZWQgTGlua2VkSW4NCmRhdGFiYXNlLCB3ZSB3aWxsIHB1bGwgdGFyZ2V0
ZWQgZGF0YWJhc2VzIGZvciB5b3Ugd2l0aCB0aGVpciBMaW5rZWRJbg0KcHJvZmlsZSBsaW5rLCBu
YW1lLCB0aXRsZSwgZW1haWwgYWRkcmVzcywgY29tcGFueSBuYW1lLCBjaXR5LCBjb21wYW55DQpz
aXplIGV0Yy4gUGxlYXNlIHNoYXJlIHlvdXIgdGFyZ2V0IGF1ZGllbmNlIGFuZCBJIHdpbGwgc3Vw
cGx5IHRoZQ0Kc2FtcGxlIHdpdGhpbiAxIGJ1c2luZXNzIGRheXPigJkgdGltZS4NClRoYW5rcyBh
bmQgbGV0IG1lIGtub3cuDQpHYXJjaWEgVGF5bG9yDQpMZWFkIGdlbmVyYXRpb24gVGVhbQ0KUHJl
bWl1bSBMaW5rZWRJbiBEYXRhYmFzZQ0KVW5zdWJzY3JpYmUNCmh0dHBzOi8vY2hhaXJtYW5ldmVu
dHN1bW1pdC5pbmZvL2VtbS9pbmRleC5waHAvbGlzdHMvdHIzODQyd3hnZWZhMi91bnN1YnNjcmli
ZS94ajk0MDhyMXF0ZjI3L2ptNzcxMjkxM3Y4NWMNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
