Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47398491FF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 23:09:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02EEA2129EB84;
	Mon, 17 Jun 2019 14:09:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A08FC212741F2
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 14:09:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e8so10216738otl.7
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WJY8mRWNKYbMrxiqtcC6On1cSl2WUj/ZIwS4ootoQak=;
 b=1CPoHsv8eJYyjii0r2v+tpwEGCkSWwSYtZacx/AqtzGMRs3fZPgZrV7RbEeA45KDwP
 lsJvq7QgmiqEwVzp5wdQHibzWroOdc9btguH5MJ/BTdcEtQKRrkY2A644oJ5v1entk28
 jQX1i10dz7Bzaag9WMXeIi4g9aL/drgYMGhz0EwOOdHkXNcNmVY9Lux9aw2TbX6HsoFA
 rgd+c/SR//qS9xH7huYep7vdqcSElSiqUL7CnczUCly0wMqqGAQdyboSJvis9joomSOv
 KyK08LiIatM0igaxt5Yo3ksIlA7sTKvevIo1tgB6DFbvKhgZgBfO8B1hLUl5bdDehAB/
 2KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WJY8mRWNKYbMrxiqtcC6On1cSl2WUj/ZIwS4ootoQak=;
 b=SZxL/vetQmIDg0Q5OvGJ/AgbVarVPL3SiyYR+KZCnGvC3CIDs4JogQqybfRD11cn9a
 t9BjKBLACquXqovx/71+KlEuHA9SzHkpcn5kUJzkhIg+w9ZPem675evPCC6/AQYIiqNH
 t4xQcmbsA+BBGW9gCEh+GocHjhPgxsoWQkSY0yiw43YX/gZrAlonF4a5w2hID9r/sr96
 uVt0jswIzWaP1ogyky8au5S70Qv4x5A4PM/yi7J52wZZMbPWw40W6i1gtUnLc7qkdV/H
 a6/LNEuvZV/eLcPS1VX1r+Bl1iMcwCxODRJBfwKdnIBM5a4jqEahlIkJ4Q/7KJl+8p3u
 Poig==
X-Gm-Message-State: APjAAAWDfpOau817cHZngTRuA4QOLx9VcYBOaNAb4wy6VoKz3ZKtnTfj
 jVbw0axQwecbHz2JmA9D3BDo3+Ke/Ghbn4szDPnDgA==
X-Google-Smtp-Source: APXvYqyAU1TcMvPiGYVYhBbyC0eVXwwhkAqKTWqXoLyuFCBz8f0kthsk9jFJXToSNfs33gSFBQCmV/94ID8R2le9oJQ=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr55835238otn.247.1560805775819; 
 Mon, 17 Jun 2019 14:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-9-hch@lst.de>
 <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
 <20190617195526.GB20275@lst.de>
In-Reply-To: <20190617195526.GB20275@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Jun 2019 14:09:24 -0700
Message-ID: <CAPcyv4iYP-7QtO7hDkAeaxJsfUCrCTBSJi3bK6e5v-VVAKQz-w@mail.gmail.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
To: Christoph Hellwig <hch@lst.de>
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
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gTW9uLCBKdW4gMTcsIDIwMTkgYXQgMTI6NTkgUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdW4gMTcsIDIwMTkgYXQgMTA6NTE6MzVBTSAtMDcw
MCwgRGFuIFdpbGxpYW1zIHdyb3RlOgo+ID4gPiAtICAgICAgIHN0cnVjdCBkZXZfcGFnZW1hcCAq
cGdtYXAgPSBfcGdtYXA7Cj4gPgo+ID4gV2hvb3BzLCBuZWVkZWQgdG8ga2VlcCB0aGlzIGxpbmUg
dG8gYXZvaWQ6Cj4gPgo+ID4gdG9vbHMvdGVzdGluZy9udmRpbW0vdGVzdC9pb21hcC5jOjEwOTox
MTogZXJyb3I6IOKAmHBnbWFw4oCZIHVuZGVjbGFyZWQKPiA+IChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhfcGdtYXDigJk/Cj4KPiBTbyBJIHJlYWxseSBzaG91
bGRuJ3QgYmUgdHJpcHBpbmcgb3ZlciB0aGlzIGFueW1vcmUsIGJ1dCBjYW4gd2Ugc29tZWhvdwo+
IHRoaXMgbWVzcz8KPgo+ICAtIGF0IGxlYXN0IGFkZCBpdCB0byB0aGUgbm9ybWFsIGJ1aWxkIHN5
c3RlbSBhbmQga2NvbmZpZyBkZXBzIGluc3RlYWQKPiAgICBvZiBzdGFzaGluZyBpdCBhd2F5IHNv
IHRoYXQgdGhpbmdzIGxpa2UgYnVpbGRib3QgY2FuIGJ1aWxkIGl0Pwo+ICAtIGF0IGxlYXN0IGFs
bG93IGJ1aWxkaW5nIGl0ICh1bmRlciBDT01QSUxFX1RFU1QpIGlmIG5lZWRlZCBldmVuIHdoZW4K
PiAgICBwbWVtLmtvIGFuZCBmcmllbmRzIGFyZSBidWlsdCBpbiB0aGUga2VybmVsPwoKRG9uZTog
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTAwMDQ3Ny8KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcg
bGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
