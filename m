Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D082A5A16
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 23:28:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25BD71652CE57;
	Tue,  3 Nov 2020 14:28:53 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a06:dd00:1:4:1::2c6; helo=s317931.savps.ru; envelope-from=add@s317931.savps.ru; receiver=<UNKNOWN> 
Received: from s317931.savps.ru (unknown [IPv6:2a06:dd00:1:4:1::2c6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01B6D1652CE55
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=s317931.savps.ru; s=dkim; h=Sender:Content-Type:MIME-Version:Date:Subject:
	From:Message-ID:Reply-To:To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V6O8npAlBxow57FOD/AvPAVE2ib4fAwLkynRqAd9Gr8=; b=P95w03ygpRmcSRUTYD2Bm7xKYc
	6FeqPNM/fjA83ZgrpvKwbh2t/cEdbw4MFg6cyTa6MPZPFVdh+/hYgQN6YN2TX+A/chKjrbfu5x1uv
	KPW/PKW2QN5WDIjVS3K/GAzpLo/382Dt9/BpqUEtfjLaxcCfgfAmMRYnzLBvqcLL9O4w=;
Received: by s317931.savps.ru with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.94)
	id 1ka4nE-0006Fv-KF; Wed, 04 Nov 2020 01:28:44 +0300
Message-ID: <EAEF590A01D5EE5D8184CD4E0A9CB32C@meta.ua>
From: "SITE" <innforms@meta.ua>
Subject: =?windows-1251?B?zu/y6Ozo5+D26P8g6CDv8O7k4ujm5e3o5SDR?=
	=?windows-1251?B?wMnSzsIg7eAgz8XQwtPeIPHy8ODt6PbzIO/u?=
	=?windows-1251?B?6PHq7uL79SDx6PHy5ewh?=
Date: Wed, 4 Nov 2020 00:24:51 +0200
MIME-Version: 1.0
X-Antivirus: Avast (VPS 201103-6, 03.11.2020), Outbound message
X-Antivirus-Status: Clean
Sender: add@s317931.savps.ru
Message-ID-Hash: 7J6BPTIXGIYVRT53PFDUGBIGGZV22PV2
X-Message-ID-Hash: 7J6BPTIXGIYVRT53PFDUGBIGGZV22PV2
X-MailFrom: add@s317931.savps.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="windows-1251"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7J6BPTIXGIYVRT53PFDUGBIGGZV22PV2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

z/Du5OLo5uXt6OUg8eDp8u7iIOIg0s7PLTMNCg0K0s7L3MrOICLBxcvbxSIgzMXSzsTbIM/QzsTC
yMbFzcjfINHAydLOwiENCg0KzPsg5+Dt6Ozg5ezx/yDv8O7k4ujm5e3o5ewg8eDp8u7ioOIgR09P
R0xFIOggWUFOREVYDQoNCtfy7uEgwuD4IPHg6fIg7eD34Osg7/Do7e7x6PL8IO/w6OH76/wsIO3z
5u3uIPDg8erw8/Lo8vwg5ePuIOIg7+7o8eru4vv1IPHo8fLl7OD1IO/uIO3z5u377CDC4Owg8evu
4uDsXPTw4Ofg7Cwg6iDv8Ojs5fDzIOXx6+ggwuD44CDk5f/y5ev87e7x8vwgz87LyMPQwNTI3ywg
8u4g7/DoIOLi7uTlIOIg7+7o8eru4ujqIP3y7uPuIPHr7uLgLCDC4Pgg8eDp8iDk7uvm5e0g4fvy
/CDt4CDv5fDi7ukg8fLw4O3o9uUg4iDv7ujx6uUsIOjt4PflIMLg+Oj1IO/u8uXt9ujg6/zt+/Ug
6uvo5e3y7uIg5+Dh5fDz8iDC4PjoIOru7erz8OXt8vsuoA0KDQrS8Ogg+ODj4CDqIO/w7uTi6Obl
7ej+IMLg+OXj7iDx4Ony4CENCg0Kz87Ewc7QIMrL3tfFwtvVINTQwMcgxMvfINHAydLADQrM+yDh
5fHv6+Dy7e4g7/Du4uXk5ewg4O3g6+jnIMLg+OXj7iDx4Ony4CDoIOL7+Ovl7CDC4Owg8e/o8e7q
IPTw4Ocg7+4gwuD45ekg8uXs4PLo6uUuDQoNCtHFziDOz9LIzMjHwNbI3yDRwMnSwKANCs3g7+jx
4O3o5SDn4OPu6+7i6u7iLCDv8ODi6Ov87fv1INHFziDu7+jx4O3o6Swg6uv+9+Xi+/Ug9PDg5yDo
IO/l8OXr6O3q7uLq4CDx8vDg7ej2Lg0KDQrP0M7EwsjGxc3IxSDPziDKy97XxcLbzCDU0MDHwMwN
Cs/w7uTi6Obl7ejlIPHg6fLgIO/uIOL74fDg7e377CDC4OzoIOrr/vfl4vvsIPTw4Ofg7CDiINLO
zyDv7ujx6u7i+/Ug8ejx8uXsLg0KDQrK4Oog5+Dq4Ofg8vwg7/Du5OLo5uXt6OUg8eDp8uANCg0K
xOv/IOfg6uDn4CDv8O7k4ujm5e3o/yDC4Pjl4+4g8eDp8uAg7eDv6Pjo8uUg7eDsIOXj7iDg5PDl
8Swg7Psg7/Du4uXk5ewg4O3g6+jnIOggwvv46+XsIMLg7CDv8OXk6+7m5e3o5SDv7iDv8O7k4ujm
5e3o/iDiINLOzyDv7ujx6u7i+/Ug8ejx8uXsLg0KDQrRINPi4Obl7ejl7CDC6+Dk6Ozo8CDA6+Xq
8eDt5PDu4uj3DQoNCnRlbDogKzM4MDYzNDAxMDc0MQ0KDQpza3lwZTogb3JnLXJlZXN0cg0KDQpt
YWlsOiBpbmZvby11YUBiaWdtaXIubmV0DQoNCs7y6uDn4PL88f8g7vIg8ODx8fvr6uig6OvooOjn
7OXt6PL8IOru7fLg6vLt8/4g6O307vDs4Pbo/i4NCg0KDQotLSANCt3y7iDx7u7h+eXt6OUg7/Du
4uXw5e3uIO3gIOLo8PPx+yDg7fLo4ujw8/Hu7CBBdmFzdC4NCmh0dHBzOi8vd3d3LmF2YXN0LmNv
bS9hbnRpdmlydXMNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
