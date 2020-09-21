Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DA2718E4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 03:04:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BB851429D11F;
	Sun, 20 Sep 2020 18:04:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=achirvasub@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8BA0B1429D11B
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 18:04:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id w16so13399851qkj.7
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=J+72f74yklzbZwXPP/c2OtPvu+CoHTqGx/+ZolI+Gk0=;
        b=ckVyyTJGF5Y1Z9fAoreEpqyMMBkWSp8ECLjz5+k8BiG6S7sUhA69mU8DKBqfiF/3o7
         jSpiDd2KpXc7mx8l7OOoJujsiimng5p/XM/lDBhkiJoVLu3QqVi1QKshKoRZLOUiXpcO
         rwII/IHwLMt1SIAEyNPkxZiIC3Zk+0K+X7hWOgh5/J1zoI0WISU+2dVID3EnVSiqhNiN
         20oLhKp2mVlrFNY/wjSOerVdypv0yPEfVbRnIRw7RfD0Um+WqBLnakDqHehcO7oo5MZc
         EvzVKvxYqU3XGhtidt6sCS9L7XhZUJbbbPxY7xa+toBwvlj25kOMLLLjs/eEyZnX0UQs
         CtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=J+72f74yklzbZwXPP/c2OtPvu+CoHTqGx/+ZolI+Gk0=;
        b=tgVYqK83stt0SdA0xL5/Nxri7P86Ynep7Jyq+pP07MI1pIin8XFSDxC5+NfpvyIRgs
         V2SuigzWo1o55dHqycexPvFBghDTzfZ/mprirsqzCaBbvqJuPJSyC0Ez/lfJ7a5vd+nw
         or/rzY2t4JpbbrNRN4weuRfp5mzFVMtB42P9nHgS4VBqE+g5xC4RyGRxINLZy3EtuZ4f
         lGrB/8gRbKHF2V/JaGVmPauvYBh3tIEttAE9rOViU2q5dC8KKlkLbXxnQSNFxcjppeqB
         43lwd+zjr3yDnPKePlUwm5MK4qbfUQku3SUuJi/Oa19cydNDQfhtczuf0rw7pMIIAdHz
         xI7w==
X-Gm-Message-State: AOAM533fYubPLX8Cf/vy/9ZtAMu42eeQdgi8+9e+6BNUFg2P1ZWJhRWU
	2mIZTw7tax6i9pexiBA39x0=
X-Google-Smtp-Source: ABdhPJy31XmM6/H23APRyy8cX0tcIFePSKgZW4BT9H+DBkWaNJ5upMkwt2Gm2IG9smvD3WpFT+yLig==
X-Received: by 2002:a37:64d4:: with SMTP id y203mr42807562qkb.359.1600650241614;
        Sun, 20 Sep 2020 18:04:01 -0700 (PDT)
Received: from arch-chirva.localdomain (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id v30sm8744438qtj.52.2020.09.20.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:04:00 -0700 (PDT)
Date: Sun, 20 Sep 2020 21:03:59 -0400
From: Stuart Little <achirvasub@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: PROBLEM: 5.9.0-rc6 fails to =?utf-8?Q?comp?=
 =?utf-8?Q?ile_due_to_'redefinition_of_=E2=80=98dax=5Fsupported=E2=80=99'?=
Message-ID: <20200921010359.GO3027113@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-ID-Hash: XLJJTDPTPRGNN7R5P76NQTM6RBYLYH7S
X-Message-ID-Hash: XLJJTDPTPRGNN7R5P76NQTM6RBYLYH7S
X-MailFrom: achirvasub@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: kernel list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XLJJTDPTPRGNN7R5P76NQTM6RBYLYH7S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBhbSB0cnlpbmcgdG8gY29tcGlsZSBmb3IgYW4geDg2XzY0IG1hY2hpbmUgKEludGVsKFIpIENv
cmUoVE0pIGk3LTc1MDBVIENQVSBAIDIuNzBHSHopLiBUaGUgY29uZmlnIGZpbGUgSSBhbSBjdXJy
ZW50bHkgdXNpbmcgaXMgYXQNCg0KaHR0cHM6Ly90ZXJtYmluLmNvbS94aW43DQoNClRoZSBidWls
ZCBmb3IgNS45LjAtcmM2IGZhaWxzIHdpdGggdGhlIGZvbGxvd2luZyBlcnJvcnM6DQoNCi0tLSBj
dXQgaGVyZSAtLS0NCg0KZHJpdmVycy9kYXgvc3VwZXIuYzozMjU6NjogZXJyb3I6IHJlZGVmaW5p
dGlvbiBvZiDigJhkYXhfc3VwcG9ydGVk4oCZDQogIDMyNSB8IGJvb2wgZGF4X3N1cHBvcnRlZChz
dHJ1Y3QgZGF4X2RldmljZSAqZGF4X2Rldiwgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCiAg
ICAgIHwgICAgICBefn5+fn5+fn5+fn5+DQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9k
YXgvc3VwZXIuYzoxNjoNCi4vaW5jbHVkZS9saW51eC9kYXguaDoxNjI6MjA6IG5vdGU6IHByZXZp
b3VzIGRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmSB3YXMgaGVyZQ0KICAxNjIgfCBz
dGF0aWMgaW5saW5lIGJvb2wgZGF4X3N1cHBvcnRlZChzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2Rl
diwNCiAgICAgIHwgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4NCiAgQ0MgICAgICBs
aWIvbWVtcmVnaW9uLm8NCiAgQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV92cmFtX2hl
bHBlci5vDQptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjgzOiBkcml2ZXJz
L2RheC9zdXBlci5vXSBFcnJvciAxDQptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVp
bGQ6NTAwOiBkcml2ZXJzL2RheF0gRXJyb3IgMg0KbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVu
ZmluaXNoZWQgam9icy4uLi4NCg0KLS0tIGVuZCAtLS0NCg0KVGhhdCdzIGVhcmxpZXIgb24sIGFu
ZCB0aGVuIGxhdGVyLCBhdCB0aGUgZW5kIG9mIHRoZSAoZmFpbGVkKSBidWlsZDoNCg0KbWFrZTog
KioqIFtNYWtlZmlsZToxNzg0OiBkcml2ZXJzXSBFcnJvciAyDQoNClRoZSBmdWxsIGJ1aWxkIGxv
ZyBpcyBhdA0KDQpodHRwczovL3Rlcm1iaW4uY29tL2loeGoNCg0KYnV0IEkgZG8gbm90IHNlZSBh
bnl0aGluZyBlbHNlIGFtaXNzLiA1LjkuMC1yYzUgYnVpbHQgZmluZSBsYXN0IHdlZWsuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
