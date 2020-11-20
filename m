Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1362BA06F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 03:30:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5F2E100EF257;
	Thu, 19 Nov 2020 18:30:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.186; helo=ceo1.edmceoattendevent.info; envelope-from=info-linux+2dnvdimm=lists.01.org@edmceoattendevent.info; receiver=<UNKNOWN> 
Received: from ceo1.edmceoattendevent.info (ip186.ip-51-68-149.eu [51.68.149.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32292100EF256
	for <linux-nvdimm@lists.01.org>; Thu, 19 Nov 2020 18:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=edmceoattendevent.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@edmceoattendevent.info;
 bh=68qA/l53Y38c6H5UcTvZEkyxx4g=;
 b=jDLi9yb0SfkH7mZmmDJFNMu9wZKxGM6nhQ/elW5GlQcjXscue3F8ca66MzrellRpjnAoQFc3TL7P
   tGNQMwxnpkIsdOGdl7HJ/7eh9WyZ08pdIpgyvjIVqx6InPp9QyouQjhjA/l9eZygWcPRUNU+i55c
   cTcQmSq8Ks5Mi/WmvmokHDMkCno8DGC7vxVhFdqHoiLiKjz01D6URcGtYmG45gYaVE3Y/1mZDXyv
   e+WZajsraAPYVEuII515AZKqAx/Szj0Ao+/baClLTig+rhwqytbXP8umc3UUBksPD4DVSq5CGD+S
   KrEBRMCi1cd1Igu0n3aNIRb5FSEY/cBVbo0MDg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=edmceoattendevent.info;
 b=Csw2vRClPkXLAll6OsGq3E9vvfYswKYacs1Rz0fGKYuwAwkoja5BbO6vCjem/lKYYBqY0k4GQF7B
   tbxVhLTLcZu4Ix47I7KIuiBFyoyIVa+afEAiYT6V6u7MPGkSw5v+0zBMbBj3wxEJRTdwvFPPs9Gq
   b/b9fUjgMFdrxjXS2VN+33EBJpZHbcxs+R42wZvT9i3Ryy1IT2lTarD9SgEDBVOqWAwI/Q1FI/38
   cdwCnLGYDYY4g7TUVALFeuhsk3rh9nNTnFw+MScOnXOgiXCSKaLzg3I78U2RmoAmN9rc8CQ0IcRF
   99hQtOBAVwUmSKoT5WbsIp91abnShkmDwadbwg==;
Received: from edmceoattendevent.info (54.37.138.114) by ceo1.edmceoattendevent.info id hmsl4fi19tkm for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 02:30:27 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@edmceoattendevent.info>)
Date: Fri, 20 Nov 2020 02:30:27 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Olivia Hernandez <info@edmceoattendevent.info>
Subject: RE: Cloud Migration Proposal
Message-ID: <d771e07153274659ffa1544ce297f0c7@edmceoattendevent.info>
X-Rcde-Campaign-Uid: kn631kbzav684
X-Rcde-Subscriber-Uid: fb19497q91621
X-Rcde-Customer-Uid: kj6787n91o3e8
X-Rcde-Customer-Gid: 0
X-Rcde-Delivery-Sid: 1
X-Rcde-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://edmceoattendevent.info/latest/index.php/campaigns/kn631kbzav684/report-abuse/ay101dvrdye9a/fb19497q91621
Feedback-ID: kn631kbzav684:fb19497q91621:ay101dvrdye9a:kj6787n91o3e8
Precedence: bulk
X-Rcde-EBS: https://edmceoattendevent.info/latest/index.php/lists/block-address
X-Sender: info@edmceoattendevent.info
X-Receiver: linux-nvdimm@lists.01.org
X-Rcde-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: QP72A3RW2XJVH7CRQDGPRR6ZD65O2RGK
X-Message-ID-Hash: QP72A3RW2XJVH7CRQDGPRR6ZD65O2RGK
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@edmceoattendevent.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Olivia Hernandez <olivia@skptywceo.biz>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QP72A3RW2XJVH7CRQDGPRR6ZD65O2RGK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBob3BlIGFsbCBpcyB3ZWxsIHdpdGggeW91LCB5b3VyIGZhbWlseSwgZnJpZW5kcyBhbmQgY29s
bGVhZ3Vlcy7CoA0KQXQgNTAlIGNvc3Qgd291bGQgeW91IGxpa2UgdG/CoG1pZ3JhdGXCoHRvIFB1
YmxpY8KgQ2xvdWRzwqAoQVdTLA0KQXp1cmUsIEdDUCBvciBTYWxlc2ZvcmNlKT8NCldlIGhhdmUg
cHJvdmVuIGV4cGVydGlzZSBpbiBldmVyeSBhc3BlY3Qgb2bCoENsb3VkwqBFbmdpbmVlcmluZw0K
YW5kwqBNaWdyYXRpb24uwqAgT3VyIGNsaWVudHMgaW5jbHVkZSBTaWxpY29uIFZhbGxleSBMZWFk
ZXJzLCBGb3J0dW5lDQoxMDAgY3VzdG9tZXJzIGFuZCBtaWQtbWFya2V0IGNsaWVudHMuIFdlIGhl
bHAgb3VyIGNsaWVudHMgYWNoaWV2ZQ0KdGhlwqBtaWdyYXRpb27CoGluIGEgVGltZSBCb3hlZCwg
QnVkZ2V0IEJveGVkLCBSaXNrLW1pdGlnYXRlZA0KYXBwcm9hY2guwqBXZSBhcmUgZmxleGlibGUg
aW4gb3VyIGJ1c2luZXNzIGFwcHJvYWNoIOKAkyB3ZSBjYW4gZG8NCkZpeGVkIFByaWNlIGNvbnRy
YWN0cyBvciBkbyBUaW1lIGFuZCBNYXRlcmlhbHMuIFdlIGFyZSBwcm9kdWN0DQphZ25vc3RpYy4g
V2UgYXJlIHZlcnkgZmFtaWxpYXIgd2l0aCB0aGUgYmVzdCBpbiBjbGFzcyB0b29scyB0byBoZWxw
DQp5b3UgaW4geW91csKgY2xvdWTCoGpvdXJuZXkgLg0KSWYgdGhpcyBtaWdodCBiZSBvZiBpbnRl
cmVzdCB0byB5b3UswqBjYW4geW91IHN1Z2dlc3QgYSAxMCBtaW4gc2xvdA0KdGhhdCB3aWxsIHdv
cmsgZm9yIHlvdT8NCkJlc3Qgd2lzaGVzIHRvIHlvdSBhbmQgeW91ciBmYW1pbHkgZm9yIGhlYWx0
aCBhbmQgd2VsbG5lc3MuDQpSZWdhcmRzLCBUaGFuayB5b3UuDQpPbGl2aWEgSGVybmFuZGV6DQpD
bG91ZMKgTWlncmF0aW9uwqAmIEJ1c2luZXNzIERldmVsb3BtZW50DQooNjc4KSA3NDUtODM4NQ0K
VW5zdWJzY3JpYmUNCmh0dHBzOi8vZWRtY2VvYXR0ZW5kZXZlbnQuaW5mby9sYXRlc3QvaW5kZXgu
cGhwL2xpc3RzL2F5MTAxZHZyZHllOWEvdW5zdWJzY3JpYmUvZmIxOTQ5N3E5MTYyMS9rbjYzMWti
emF2Njg0DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
