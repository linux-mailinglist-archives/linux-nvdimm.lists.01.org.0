Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD956E80
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 18:14:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA7BB212AB010;
	Wed, 26 Jun 2019 09:14:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4AC4E212AB00A
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n5so1308501otk.1
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XK0CaHJOVcsS/u0euQkBQYUAFEHomal+V6KfwmFuG+U=;
 b=l+5kJ6tokPJ98bH2NME9M/AQ27NvFMKuOsXn1/Bb6bOBzelrSngvtDZJXmVwZKzpKi
 qjSD/BPNZzWpZiBQzbopXZ4t+Owe9yGEnJZxcLTPAlrrPvnYO2K7gCbSAaaiJHFcBp4k
 rxUq8p1DHnLMI0fRDu2WCtVRP/OHmPtRFurCHJX0OhgjoUZQUqGECtXD/hiUSR9PPelH
 MnkCXYqaYmm4WKtHJZYWuY7L6Kj9qhni0KNGsJokbTzfJurnEEHErfJ69HKEvmfEeo+E
 N7IwPwAkdbg4plX6eEOz52RHtcXnuvonc5/m143W02YNIvHsz5xJAtpZFJ8Hrcf91kdm
 NShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XK0CaHJOVcsS/u0euQkBQYUAFEHomal+V6KfwmFuG+U=;
 b=jSQjY0jXMT5o2V/lM45Wcvaf6jrbefoOMRoSGmqZj28Ikb3WTG02L1CZQ1McMW5TMe
 H6Ou9rS8QS+Wv4xayyF/msR8JSQiN+AzRU06bo1k8lsvESCyWr82bUhS7MgnhDagzpjY
 wN02COaVVNmgHTJWuayVnvF4nrgMn5SAsxKlk9uf3TvFF9cx+zm42q9guzaxgTUQgr8x
 gVHrefNVKn5LrtW0M4M//fArnIKqzJ4xsSIQG5NwYG6nVG8w7qERdCibGdvtZwfgs+ON
 QHbCYPssJK1Lo4FjTE/DAzs5z5NXZUCQbb2BKt6IlPcz5sDGIyh/z5/Z6mbbytnwX0gJ
 paDQ==
X-Gm-Message-State: APjAAAX3J6KVyFUfZU6hFGc4yHJ1Ewn242kG7u+aK6VxbpJDii4Co0IW
 63EazZ7i5JDbgBTEceIWhXgzjrq8piSehJ06DHAl6A==
X-Google-Smtp-Source: APXvYqxlK4A4nPLhfNez6panLCe0oG2uZ68rpjoeO+K9OBDO45YdiJCTPi2DLYKpN0RI7gOpjzzUX8DJkFMKIZ4j7YA=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr1155884otn.71.1561565683159; 
 Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
 <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de> <20190625150053.GJ11400@dhcp22.suse.cz>
 <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
 <20190625190038.GK11400@dhcp22.suse.cz>
 <CAPcyv4hU13v7dSQpF0WTQTxQM3L3UsHMUhsFMVz7i4UGLoM89g@mail.gmail.com>
 <20190626054645.GB17798@dhcp22.suse.cz>
In-Reply-To: <20190626054645.GB17798@dhcp22.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Jun 2019 09:14:32 -0700
Message-ID: <CAPcyv4jLK2F2UHqbwp4bCEiB7tL8sVsr775egKMmJvfZG+W+NQ@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To: Michal Hocko <mhocko@kernel.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NDYgUE0gTWljaGFsIEhvY2tvIDxtaG9ja29Aa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUgMjUtMDYtMTkgMTI6NTI6MTgsIERhbiBXaWxsaWFt
cyB3cm90ZToKPiBbLi4uXQo+ID4gPiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxlLWFwaS1u
b25zZW5zZS5yc3QKPiA+Cj4gPiBUaGF0IGRvY3VtZW50IGhhcyBmYWlsZWQgdG8gcHJlY2x1ZGUg
c3ltYm9sIGV4cG9ydCBmaWdodHMgaW4gdGhlIHBhc3QKPiA+IGFuZCB0aGVyZSBpcyBhIHJlYXNv
bmFibGUgYXJndW1lbnQgdG8gdHJ5IG5vdCB0byByZXRyYWN0IGZ1bmN0aW9uYWxpdHkKPiA+IHRo
YXQgaGFkIGJlZW4gcHJldmlvdXNseSBleHBvcnRlZCByZWdhcmRsZXNzIG9mIHRoYXQgZG9jdW1l
bnQuCj4KPiBDYW4geW91IHBvaW50IG1lIHRvIGFueSBzcGVjaWZpYyBleGFtcGxlIHdoZXJlIHRo
aXMgd291bGQgYmUgdGhlIGNhc2UKPiBmb3IgdGhlIGNvcmUga2VybmVsIHN5bWJvbHMgcGxlYXNl
PwoKVGhlIG1vc3QgcmVjZW50IGV4YW1wbGUgdGhhdCBjb21lcyB0byBtaW5kIHdhcyB0aGUgdGhy
YXNoIGFyb3VuZApfX2tlcm5lbF9mcHVfe2JlZ2luLGVuZH0gWzFdLiBJIHJlZmVyZW5jZWQgdGhh
dCB3aGVuIGRlYmF0aW5nIF9HUEwKc3ltYm9sIHBvbGljeSB3aXRoIErDqXLDtG1lIFsyXS4KClsx
XTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDUyMjEwMDk1OS5HQTE1MzkwQGty
b2FoLmNvbS8KWzJdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBUGN5djRnYityPT1y
aUtGWGtWWjdnR2RuS2U2MnlCbVo3eE9hNHVCQkJ5aG5LOVR6Z0BtYWlsLmdtYWlsLmNvbS8KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
