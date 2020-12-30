Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58032E76F8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Dec 2020 09:18:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1046100EC1CD;
	Wed, 30 Dec 2020 00:18:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::946; helo=mail-ua1-x946.google.com; envelope-from=3wzfsxwojdogb.kusnitkkqwksv.mywvsxeh-xfnswwvscdc.kl.ybq@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-ua1-x946.google.com (mail-ua1-x946.google.com [IPv6:2607:f8b0:4864:20::946])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76978100EC1CC
	for <linux-nvdimm@lists.01.org>; Wed, 30 Dec 2020 00:18:13 -0800 (PST)
Received: by mail-ua1-x946.google.com with SMTP id 9so7165839uas.17
        for <linux-nvdimm@lists.01.org>; Wed, 30 Dec 2020 00:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=IbutNvw1r5Pupmiw1qSbRiGWyE1r38n4U6DpkFTmS0c=;
        b=qbX8Ue1lnZITkplDpPQNzJ+MlEboKqeqbVObSiJdqpb6wxc/L5XuwUfDPxYiALQ5Dg
         IWLVzx7ZcW6Xsy/Gn0hn8mvzRP5i+X0qs/u0t+q+tPLxQ7XLXZni0XbaWHdzJ9sbCaHg
         uKklCsWp3HrtyrX5iZwbx4sUo++eKVEmmGHZYNw7sU4iCvDHXYtkr4RtvbkpB0wzKRPJ
         QJHcG/dHOj0xb4u9K545mpjYfJrXcCTmAfYjWz5k4z9jEEg0A/JAWsVYqlIq1LEAkho2
         eDkKNo/k82o4KZ1/SuGL2GX8CaavS+7MaBHwfy9oHf9oyAqVXQpKt/55uSPuuDcB6I/J
         E79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=IbutNvw1r5Pupmiw1qSbRiGWyE1r38n4U6DpkFTmS0c=;
        b=eftTBXwMS60DN8GGRMMzKvUogimGIjfePLclSfkl7xitXEq/koZjBXiTLBnmWb8kfX
         lsExSxvCBb0d5VIR+XQ9L/I/ZyTKPfv2v7BzjlEZp8MpW4eHlmBj5wDVq6VqMk2DtODT
         1Y6Dd0B5wV+7JqKuY9RFdtZcPpjFZx3QaosOdi2nOsdTy4u8GvTfXHsVaaH+cGYVC4Y5
         yiqaRub14yzAFXkP3vjOX/UyYrIXnJF2bTxn3gHN2/4lBdgASR2ACgpsMDbwA6dgkXlK
         TaF1jxoJdqqAfhWZR/l3bjXdH4Cmcs3p+k/pnEdm6SqqAx0hYQdYGuaw70l+af2GLY1o
         dNug==
X-Gm-Message-State: AOAM530saHecqgMnxVrMGc/8g4VTBESQljU2bQP+BmumAam7Gyg/pBJ+
	csOI/wCN88j4EVpOKAnPk/cnEhCFdkokxDc/iaw+
MIME-Version: 1.0
X-Received: by 2002:a05:6102:214e:: with SMTP id h14mt35029544vsg.39.1609316291715;
 Wed, 30 Dec 2020 00:18:11 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <000000000000e63d7305b7aa25fa@google.com>
Date: Wed, 30 Dec 2020 08:18:12 +0000
Subject: ralli
From: r.akidy90a@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: OYZHDBYYL7BVYDDMOBC5XTPCN6C2ANRK
X-Message-ID-Hash: OYZHDBYYL7BVYDDMOBC5XTPCN6C2ANRK
X-MailFrom: 3wzfsXwoJDOgb.KUSNitkKQWKSV.MYWVSXeh-XfNSWWVScdc.kl.YbQ@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: r.akidy90a@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYZHDBYYL7BVYDDMOBC5XTPCN6C2ANRK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: base64

SmUgdm91cyBhaSBpbnZpdMOpIMOgIHJlbXBsaXIgbGUgZm9ybXVsYWlyZSBzdWl2YW50wqA6DQpG
b3JtdWxhaXJlIHNhbnMgdGl0cmUNCg0KUG91ciByZW1wbGlyIGNlIGZvcm11bGFpcmUsIGNvbnN1
bHRlesKgOg0KaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZm9ybXMvZC9lLzFGQUlwUUxTZWNCU2xT
U2wtenlRR05pV2g2bEZZeTZlTnpKRnRqZW9MdjRlMVlnNUhVVmFaVDh3L3ZpZXdmb3JtP3ZjPTAm
YW1wO2M9MCZhbXA7dz0xJmFtcDtmbHI9MCZhbXA7dXNwPW1haWxfZm9ybV9saW5rDQoNCmZyb20g
cmFsbGkgYWtpZHkNCg0KDQpQbGVhc2UgaSBuZWVkIHlvdXIgaGVscCxQZXJtaXQgbWUgdG8gaW5m
b3JtIHlvdSBvZiBteSBkZXNpcmUgb2YgZ29pbmcgaW50byAgDQpidXNpbmVzcyByZWxhdGlvbnNo
aXAgd2l0aCB5b3UsIEkgYW0gTXMgUmFsaWkgQWtpZHkgMTkgeWVhcnMgdGhlIG9ubHkgIA0KRGF1
Z2h0ZXIgb2YgTGF0ZSBNci4gJmFtcDsgTXJzLiBVem9oIEFraWR5LiBNeSBmYXRoZXIgd2FzIGEg
dmVyeSB3ZWFsdGh5ICANCmNvY29hIG1lcmNoYW50IGluIEl2b3J5IGNvc3QgLCB0aGUgZWNvbm9t
aWMgY2FwaXRhbCBvZiBBYmlkamFuLCBteSBmYXRoZXIgIA0Kd2FzIHBvaXNvbmVkIHRvIGRlYXRo
IGJ5IGhpcyBidXNpbmVzcyBhc3NvY2lhdGVzIG9uIG9uZSBvZiB0aGVpciBvdXRpbmdzIG9uICAN
CmEgYnVzaW5lc3MgdHJpcA0KDQpNeSBtb3RoZXIgZGllZCB3aGVuIEkgd2FzIGEgYmFieSBhbmQg
c2luY2UgdGhlbiBteSBmYXRoZXIgdG9vayBtZSBzbyAgDQpzcGVjaWFsLiBCZWZvcmUgdGhlIGRl
YXRoIG9mIG15IGZhdGhlciBpbiBhIHByaXZhdGUgaG9zcGl0YWwgaGVyZSBoZSAgDQpzZWNyZXRs
eSBjYWxsZWQgbWUgb24gaGlzIGJlZCBzaWRlIGFuZCB0b2xkIG1lIHRoYXQgaGUgaGFzIHRoZSBz
dW0gb2YgZm91ciAgDQptaWxsaW9uIHR3byBodW5kcmVkIHRoYXVzYW5kIGRvbGxhci4oJDQuMk1p
bGxpb24pIFVTRCBsZWZ0IGluIGZpeGVkIC8gIA0Kc3VzcGVuc2UgYWNjb3VudCBpbiBvbmUgb2Yg
dGhlIHByaW1lIGJhbmsgaGVyZSBpbiBpdm9yeSBjb2FzdCwgaGUgc2FpZCB0aGF0ICANCmhlIHVz
ZWQgbXkgbmFtZSBhcyBoaXMgb25seSBEYXVnaHRlciBmb3IgdGhlIG5leHQgb2YgS2luIGluIGRl
cG9zaXRpbmcgb2YgIA0KdGhlIG1vbmV5LiBIZSBhbHNvIGV4cGxhaW5lZCB0byBtZSB0aGF0IGl0
IHdhcyBiZWNhdXNlIG9mIHRoaXMgd2VhbHRoIHRoYXQgIA0KaGUgd2FzIHBvaXNvbmVkIGJ5IGhp
cyBidXNpbmVzcyBzc29jaWF0ZXMuIFBsZWFzZSBpIG5lZWQgeW91IHRvIGhlbHAgbWUgdG8gIA0K
dHJhbnNmZXIgdGhlIG1vbmV5IGludG8geW91ciBhY2NvdW50IHNvIHRoYXQgaSB3aWxsIGNvbWUg
b3ZlciB0byB5b3VyICANCmNvdW50cnkgYW5kIGZpbmlzaCBteSBlZHVjYXRpb24sIFRoZW4geW91
IHB1dCB0aGUgcmFjZSBvZiB0aGUgbW9uZXkgaW4gYSAgDQpidXNpbmVzcyBhbmQgaW52ZXN0bWVu
dCBmb3IgbW9yZSBpbmNvbWUuDQoNCigxKSBpIHdhbnQgeW91IFRvIHByb3ZpZGUgYWNjb3VudCB3
aGVyZSB0aGUgYmFuayB3aWxsIHRyYW5zZmVyIHRoZSBtb25leSAuDQooMikgVG8gc2VydmUgYXMg
YSBndWFyZGlhbiBvZiB0aGlzIGZ1bmQgc2luY2UgSSBhbSBvbmx5IDE5IHllYXJzIGdpcmwuDQoo
MykgVG8gbWFrZSBhcnJhbmdlbWVudCBmb3IgbWUgdG8gY29tZSBvdmVyIHRvIHlvdXIgY291bnRy
eSB0byBmdXJ0aGVyIG15ICANCmVkdWNhdGlvbiBhbmQgdG8gc2VjdXJlIGEgcmVzaWRlbnQgcGVy
bWl0IGluIHlvdXIgY291bnRyeS4NCg0KTW9yZW92ZXIsIERlYXIsIEkgYW0gd2lsbGluZyB0byBv
ZmZlciB5b3UgMTUlIG9mIHRoZSB0b3RhbCBzdW0gYXMgIA0KY29tcGVuc2F0aW9uIGZvciB5b3Vy
IGVmZm9ydC8gaW5wdXQgYWZ0ZXIgdGhlIHN1Y2Nlc3NmdWwgdHJhbnNmZXIgb2YgdGhpcyAgDQpt
b25leSBpbnRvIHlvdXIgbm9taW5hdGVkIGFjY291bnQgc28gdGhhdCBpIHdpbGwgY29tZSBvdmVy
IHRvIHlvdXIgY291bnRyeSwNCg0KUExFQVNFIENPTlRBQ1QgTUUgRElSRUNUIFRPIE15IGVtYWls
LiAgYWtpZHkyQHlhaG9vLmNvbQ0KDQogRnJvbSB5b3VycyBmYWl0aGZ1bCBsb3ZlIHJhbGxpIGFr
aWR5DQoNCmkgYW0gd2FpdGluZyBmb3IgeW91ciByZXBseQ0KDQpHb29nbGXCoEZvcm1zIHZvdXMg
cGVybWV0IGRlIGNyw6llciBkZXMgZW5xdcOqdGVzIGV0IGQnZW4gYW5hbHlzZXIgbGVzICANCnLD
qXN1bHRhdHMuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMu
MDEub3JnCg==
