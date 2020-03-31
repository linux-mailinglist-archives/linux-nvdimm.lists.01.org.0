Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D841992A7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 11:47:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5482410FC3891;
	Tue, 31 Mar 2020 02:47:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E1D521007B1F0
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 02:47:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cw6so23587171edb.9
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wO/YEClVC4bznsIBM0aKMtzyOdSIvnqNmYs0tYYay5M=;
        b=UC9I5RYMTF9x470AM1vJkHEv3YFBzuEm+FqIWOG/BDt9pFSYSGnVQjRsEFfxYkIldW
         ZscYl4LsMwSzzOTh8nIeqrzHD7Oh7pqttet3w4SCRe3OYIG7Ny361CTK6RwOOwmH0gGe
         ozxk+sP06lknqjpKHsV05924QErWHKeyTMANMO7VXzsZeK0gvVcPjNkk0S+62vwLZglR
         5CMR15ggQLeAy7lRjsTcMklLAjoU4ukEVz4Nd/sr4ayD7GynyLDYYC70Kp8JYRS3bD7R
         UDB21oAXgUKA44UJOy7qkB/qXCRijVo47sHBmX79YUxOCOykYol9sQ+A5tNwuK2/YyPw
         PHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wO/YEClVC4bznsIBM0aKMtzyOdSIvnqNmYs0tYYay5M=;
        b=qcHRDyisXHymjPUTnJvJYcmc88B/ILGjkFHzU1ojYmZfyBOjx8y6vwPQ1P50+zJhw4
         3ZDlZ5LH+01EnvFmGj7j6zXWAQyJjokjs1vtK/Nugr8p34YikkEpdHwxBDjw8b8NI2EJ
         fzExCexwRmJ3nrVxISuw59g0mtCx6M0h/DkdefjkB3ZapXI/NLWoPD/sTYvMeyCQJPD0
         1MoPYdVZDasY0Wz0fRsZ3ObTz7jAVmltcsZ294/7y7v5/9KJE6G0x2pcQa/A28mO/u7Y
         2ijuX298GYVAfzb5Q6/SjVbxwoGkToY80+9x4Uvk5YK+r01wJvqZsqPmgevfH0bHSdOM
         NlGg==
X-Gm-Message-State: ANhLgQ1oythhn2ysIoarSsq1+m7lQT8az1GiD0hf1CCKwMeAQ7k9Cg2M
	LGgwWhifuGECr9EnDIUA6ZQ82e1caW121Oqexmow6g==
X-Google-Smtp-Source: ADFU+vvWqY2t1S0J4+IMaqLr+k2IqBAvI8NNneKhMPlo68uUyWVmxyn+o59Vbw4OGtjBIdtjhl5p3Eu+2+tXyuBD4KE=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr14186705ejj.317.1585648023325;
 Tue, 31 Mar 2020 02:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200330141943.31696-1-yuehaibing@huawei.com>
In-Reply-To: <20200330141943.31696-1-yuehaibing@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 02:46:52 -0700
Message-ID: <CAPcyv4jTTDHLpnLArL_YvnSr+FAVVOi0Xs4Wv3dBF-cgQrx7zw@mail.gmail.com>
Subject: Re: [PATCH -next] libnvdimm/region: Fix build error
To: YueHaibing <yuehaibing@huawei.com>
Message-ID-Hash: 44BGM62ZV2C53RBOYLVAAY664O2KQVN2
X-Message-ID-Hash: 44BGM62ZV2C53RBOYLVAAY664O2KQVN2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/44BGM62ZV2C53RBOYLVAAY664O2KQVN2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBNYXIgMzAsIDIwMjAgYXQgNzoyMyBBTSBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+IHdyb3RlOg0KPg0KPiBPbiBDT05GSUdfUFBDMzI9eSBidWlsZCBmYWlsczoNCj4N
Cj4gZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYzoxMDM0OjE0OiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYZG9fZGl24oCZDQo+ICAgcmVtYWluZGVyID0gZG9fZGl2KHBlcl9tYXBw
aW5nLCBtYXBwaW5ncyk7DQo+ICAgICAgICAgICAgICAgXn5+fn5+DQo+IEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2dlbmVyYXRlZC9hc20vZGl2NjQuaDoxOjAs
DQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgva2VybmVsLmg6MTgsDQo+
ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvYXNtLWdlbmVyaWMvYnVnLmg6MTksDQo+
ICAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9idWcuaDox
MDksDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYnVnLmg6NSwNCj4g
ICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oOjcsDQo+
ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jOjU6DQo+
IC4vaW5jbHVkZS9hc20tZ2VuZXJpYy9kaXY2NC5oOjI0MzoyMjogZXJyb3I6IHBhc3NpbmcgYXJn
dW1lbnQgMSBvZiDigJhfX2RpdjY0XzMy4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlw
ZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10NCj4gICAgX19yZW0gPSBfX2Rp
djY0XzMyKCYobiksIF9fYmFzZSk7IFwNCj4NCj4gVXNlIGRpdl91NjQgaW5zdGVhZCBvZiBkb19k
aXYgdG8gZml4IHRoaXMuDQo+DQo+IEZpeGVzOiAyNTIyYWZiODZhOGMgKCJsaWJudmRpbW0vcmVn
aW9uOiBJbnRyb2R1Y2UgYW4gJ2FsaWduJyBhdHRyaWJ1dGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBZ
dWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9udmRp
bW0vcmVnaW9uX2RldnMuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3Jl
Z2lvbl9kZXZzLmMgYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQo+IGluZGV4IGJmMjM5
ZTc4Mzk0MC4uMjI5MWYwNjQ5ZDI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252ZGltbS9yZWdp
b25fZGV2cy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMNCj4gQEAgLTU2
NCw3ICs1NjQsNyBAQCBzdGF0aWMgc3NpemVfdCBhbGlnbl9zdG9yZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+ICAgICAgICAgICogc3BhY2UgZm9yIHRoZSBuYW1lc3BhY2UuDQo+ICAgICAgICAgICov
DQo+ICAgICAgICAgZHBhID0gdmFsOw0KPiAtICAgICAgIHJlbWFpbmRlciA9IGRvX2RpdihkcGEs
IG5kX3JlZ2lvbi0+bmRyX21hcHBpbmdzKTsNCj4gKyAgICAgICByZW1haW5kZXIgPSBkaXZfdTY0
KGRwYSwgbmRfcmVnaW9uLT5uZHJfbWFwcGluZ3MpOw0KDQpUaGlzIGlzIG5vdCBhbiBlcXVpdmFs
ZW50IGNvbnZlcnNpb24uDQoNCiAgICBkcGEgPSBkaXZfdTY0X3JlbSh2YWwsIG5kX3JlZ2lvbi0+
bmRyX21hcHBpbmdzLCAmcmVtYWluZGVyKTsNCg0KPiAgICAgICAgIGlmICghaXNfcG93ZXJfb2Zf
MihkcGEpIHx8IGRwYSA8IFBBR0VfU0laRQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICB8fCB2
YWwgPiByZWdpb25fc2l6ZShuZF9yZWdpb24pIHx8IHJlbWFpbmRlcikNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiBAQCAtMTAzMSw3ICsxMDMxLDcgQEAgc3RhdGljIHVuc2ln
bmVkIGxvbmcgZGVmYXVsdF9hbGlnbihzdHJ1Y3QgbmRfcmVnaW9uICpuZF9yZWdpb24pDQo+DQo+
ICAgICAgICAgbWFwcGluZ3MgPSBtYXhfdCh1MTYsIDEsIG5kX3JlZ2lvbi0+bmRyX21hcHBpbmdz
KTsNCj4gICAgICAgICBwZXJfbWFwcGluZyA9IGFsaWduOw0KPiAtICAgICAgIHJlbWFpbmRlciA9
IGRvX2RpdihwZXJfbWFwcGluZywgbWFwcGluZ3MpOw0KPiArICAgICAgIHJlbWFpbmRlciA9IGRp
dl91NjQocGVyX21hcHBpbmcsIG1hcHBpbmdzKTsNCg0KU2FtZSBwcm9ibGVtIGhlcmUuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
