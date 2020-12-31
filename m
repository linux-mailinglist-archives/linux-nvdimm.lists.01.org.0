Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A68042E7ECB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Dec 2020 09:55:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDF6D100EC1E3;
	Thu, 31 Dec 2020 00:55:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.164; helo=ceo9.trendeduedmsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@trendeduedmsummit.info; receiver=<UNKNOWN> 
Received: from ceo9.trendeduedmsummit.info (ip164.ip-51-68-149.eu [51.68.149.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 09963100EF27B
	for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 00:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=trendeduedmsummit.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@trendeduedmsummit.info;
 bh=Mggvs+9aKN+rm1HYVRVjsBf39w4=;
 b=Ak9tUp3cpf6TiPTvgF6tAhrwk7dBLQjV+rgRKPIvNXe83N1xC88o11pbuELDEVRHarjjCTCNfHyw
   naN1WCSjBvqEt5s8cXDmm3TM8uCNOjPVQNzz99d5+4sAM4KSktlfZ8XVli2uakegBZPc8ro0yftp
   ZYNsYZx3WRLzwrwx5z6q6eOqHTiBRDtj4s8+EUlKwj8jl4dKhH1skN42CaCfjerVcZTEaBNwnk3l
   ZzgmQ+h8y7OkBm/vRNW/XjYijrbN/d+88RqaT57MW6aTQqEE4vDnlcpbkZZtfvuNeUsKJdrpxOj1
   SnEsiAG209gZqeFG+WxjwH7H2DwwUyHvI+n1FA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=trendeduedmsummit.info;
 b=Wlr6owp9POa9gKfjILl4IFZcUOZGd5r12U2VdXhXYD3G/BYgiMr2O/9HCWUV7zPPkx/0sh8JKyM2
   XpiTaxmT6Nk484Sv/0wGevX4jX+KGeNdGI7X43kBicpZmJHf6vVx4KFowMb+JPtr7lEPEYxOc6Ey
   j34d26SHlHZ4LTLtNRB83DXxuRNvBIVePuCIc01xM5tTJOPe+2WSvj52Q+5GcAYmvlQGuIBvnUhH
   GdIrmdFmrqIMx1s4/IIvDBWmRHUa5WaPN7aJDhtcSmRWXkEizlNJ2EH/kAOLRqWDNk32ttSu8ci4
   DxUfWw7G7BpNQpWbvZ0A4llQus0QWejxAJgCOQ==;
Received: from trendeduedmsummit.info (127.0.0.1) by ceo1.trendeduedmsummit.info id htm91ji19tki for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 08:52:55 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@trendeduedmsummit.info>)
Message-ID: <9698ef27bc4f08a287a576e8f5ab907e@trendeduedmsummit.info>
Date: Thu, 31 Dec 2020 08:52:55 +0000
Subject: RE: did you get my email
From: Susan Taylor <info@trendeduedmsummit.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@trendeduedmsummit.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://trendeduedmsummit.info/emm/index.php/campaigns/bk628fy55j72e/report-abuse/ld6539y3c9508/pk094zp7ov0b2
X-Receiver: linux-nvdimm@lists.01.org
X-Ffws-Tracking-Did: 0
X-Ffws-Subscriber-Uid: pk094zp7ov0b2
X-Ffws-Mailer: SwiftMailer - 5.4.x
X-Ffws-EBS: http://trendeduedmsummit.info/emm/index.php/lists/block-address
X-Ffws-Delivery-Sid: 1
X-Ffws-Customer-Uid: ws867mym7e562
X-Ffws-Customer-Gid: 0
X-Ffws-Campaign-Uid: bk628fy55j72e
Precedence: bulk
Feedback-ID: bk628fy55j72e:pk094zp7ov0b2:ld6539y3c9508:ws867mym7e562
Message-ID-Hash: E632CNHH7FMNO65LW3KAXWBT5XQ4KQTV
X-Message-ID-Hash: E632CNHH7FMNO65LW3KAXWBT5XQ4KQTV
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@trendeduedmsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Susan Taylor <susan.taylordata@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E632CNHH7FMNO65LW3KAXWBT5XQ4KQTV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIDEwMCUgYWNjdXJhdGUgMTAsMDAwIFRhcmdl
dGVkIExlYWRzDQpnZW5lcmF0ZWQgZnJvbSBMaW5rZWRJbiBhdCAkNTAwKEFueSB0aXRsZS9pbmR1
c3RyeS9sb2NhdGlvbi9rZXl3b3Jkcyk/DQpJZiB5b3UgaGF2ZSBhIHZlcnkgdGFyZ2V0ZWQgZGF0
YSByZXF1aXJlbWVudCBhbmQgeW91IG5lZWQgTGlua2VkSW4NCmRhdGFiYXNlLCB3ZSB3aWxsIHB1
bGwgdGFyZ2V0ZWQgZGF0YWJhc2VzIGZvciB5b3Ugd2l0aCB0aGVpciBMaW5rZWRJbg0KcHJvZmls
ZSBsaW5rLCBuYW1lLCB0aXRsZSwgZW1haWwgYWRkcmVzcywgY29tcGFueSBuYW1lLCBjaXR5LCBj
b21wYW55DQpzaXplIGV0Yy4gUGxlYXNlIHNoYXJlIHlvdXIgdGFyZ2V0IGF1ZGllbmNlIGFuZCBJ
IHdpbGwgc3VwcGx5IHRoZQ0Kc2FtcGxlIHdpdGhpbiAxIGJ1c2luZXNzIGRheXPigJkgdGltZS4N
ClRoYW5rcyBhbmQgbGV0IG1lIGtub3cuDQpTdXNhbiBUYXlsb3INCkdsb2JhbCBMaW5rZWRJbiBE
YXRhYmFzZSBQcm92aWRlcg0KVW5zdWJzY3JpYmUNCmh0dHA6Ly90cmVuZGVkdWVkbXN1bW1pdC5p
bmZvL2VtbS9pbmRleC5waHAvbGlzdHMvbGQ2NTM5eTNjOTUwOC91bnN1YnNjcmliZS9wazA5NHpw
N292MGIyL2JrNjI4Znk1NWo3MmUNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
