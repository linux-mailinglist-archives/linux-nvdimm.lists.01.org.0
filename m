Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1735262
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Jun 2019 23:57:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 165B12128A637;
	Tue,  4 Jun 2019 14:57:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5B54C211E7454
 for <linux-nvdimm@lists.01.org>; Tue,  4 Jun 2019 14:57:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o13so21201893lji.5
 for <linux-nvdimm@lists.01.org>; Tue, 04 Jun 2019 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nm6nxsfvdF1NlydS0vPcNG8Czdz9QMNoM/DaRUKeru8=;
 b=nLRStuQzBAP59j/hKQNMV8C2AGPtk1eCG2pVy9YzYyeSjd5qJhpZEFP4EeezoVeUTW
 jCVxFCEslDbIYQBvl1fiWZwQgMWKrBfYmhsQbY0FOyfRCagOJrBrYjrjVYnfRKEkWBk3
 6ocN8V2mwExKGi+I0etI2k6Ni8hGVyzZ0e9VpFO0N23q3SvM0zXQkqkIxHDnQrOWEsbB
 6dEDi7PBY/pmmPrtXyvpaYGxcVTNutTpomS6BWz/12hpgG8D/gC5FYBWpRRzRM5m5zt8
 WdpVD7qsXc2+NJj9mv+e1rum3ydGcI/lFQo5HIg7f8lqXChuKP/uhCGMxzROQ+8FUS+v
 VZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nm6nxsfvdF1NlydS0vPcNG8Czdz9QMNoM/DaRUKeru8=;
 b=ZDNORwb3g95sZCpjAlmlGBLKCJ+dUyTTUaH3PExckxI+BqpX9pHn6NlA9JEgz48KXK
 oioDFIwkfMOCJ21wYp65PR2/OBD1E0SLp6HUxXSlJn1DZggenjkEMV8jx9WUo2hP8uLC
 VN5Dx8Fsh6/Nkwds/FK5CWeqBtQE6TA0ogSP1oNE6AkpKxlaizvzWU2uCiHpSwF+ed7V
 lzWQ7g31a+gkE0ZFvPW5eSTCKuBZVsH5aj3oYFMHyAkpJakiXI1IE43YNYVGve7zY8vJ
 ICbHp6MZIQJo+R2bVw6pjWr3Z8TrqhA6zOTfxs+j4/lBC/n6Ap5z4mDpDXrkIYukEbcG
 e3Lw==
X-Gm-Message-State: APjAAAVpuygc5P3PfnETJC7yWMpn+ax7oKGudCwHszhXfKcnI6HjTqnA
 6YyCBSqciQYwNpff2x1E7E7dw4YRIx60Yd3MTfA1qw==
X-Google-Smtp-Source: APXvYqwE1CV5WfOBv8U7SSbJEQLGVSNIIKxmFZ1p4N1xuuO/XMklmNvMFn5XfSsxTekMg8/K0WDmZz2xlx1whsztp4E=
X-Received: by 2002:a2e:a318:: with SMTP id l24mr6354112lje.36.1559685428378; 
 Tue, 04 Jun 2019 14:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-16-brendanhiggins@google.com>
 <20190514073422.4287267c@lwn.net>
 <20190514180810.GA109557@google.com> <20190514121623.0314bf07@lwn.net>
 <20190514231902.GA12893@google.com> <20190515074546.07700142@lwn.net>
In-Reply-To: <20190515074546.07700142@lwn.net>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Jun 2019 14:56:57 -0700
Message-ID: <CAFd5g44XatHJnNvRdqBGLnwcvOxTUAKM-tjKH94NGbyXGVVatQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] Documentation: kunit: add documentation for KUnit
To: Jonathan Corbet <corbet@lwn.net>
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
Cc: songliubraving@fb.com, Petr Mladek <pmladek@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, catalin.marinas@arm.com,
 Amir Goldstein <amir73il@gmail.com>, ast@kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>, oberpar@linux.ibm.com,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, netdev@vger.kernel.org,
 glider@google.com, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kgdb-bugreport@lists.sourceforge.net, shuah <shuah@kernel.org>,
 cocci@systeme.lip6.fr, Rob Herring <robh@kernel.org>,
 daniel.thompson@linaro.org, daniel@iogearbox.net,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Gilles.Muller@lip6.fr,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, kasan-dev@googlegroups.com,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 aryabinin@virtuozzo.com, Jeff Dike <jdike@addtoit.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, nicolas.palix@imag.fr, "Bird,
 Timothy" <Tim.Bird@sony.com>, jason.wessel@windriver.com,
 linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
 Julia Lawall <julia.lawall@lip6.fr>, yhs@fb.com,
 Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
 michal.lkml@markovi.net, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

U29ycnksIHRvIGVtYWlsIHNvIG1hbnkgcGVvcGxlLCBidXQgdGhlcmUgYXJlIGEgbG90IG9mIG1h
aW50YWluZXJzIGluCnRoaXMgZGlyZWN0b3J5LgoKT24gV2VkLCBNYXkgMTUsIDIwMTkgYXQgNjo0
NSBBTSBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PiB3cm90ZToKPgo+IE9uIFR1ZSwg
MTQgTWF5IDIwMTkgMTY6MTk6MDIgLTA3MDAKPiBCcmVuZGFuIEhpZ2dpbnMgPGJyZW5kYW5oaWdn
aW5zQGdvb2dsZS5jb20+IHdyb3RlOgo+Cj4gPiBIbW1tLi4ucHJvYmFibHkgcHJlbWF0dXJlIHRv
IGJyaW5nIHRoaXMgdXAsIGJ1dCBEb2N1bWVudGF0aW9uL2Rldi10b29scy8KPiA+IGlzIGtpbmQg
b2YgdGhyb3duIHRvZ2V0aGVyLgo+Cj4gV2FpdCBhIG1pbnV0ZSwgbWFuLi4uICpJKiBjcmVhdGVk
IHRoYXQgZGlyZWN0b3J5LCBhcmUgeW91IGltcHVnbmluZyBteQo+IHdvcms/IDopCgpXaGF0PyEg
SSB3b3VsZCBuZXZlciEgOy0pCgpDb250ZXh0IGZvciB0aGUgcGVvcGxlIEkganVzdCBhZGRlZDog
SSBwcm9wb3NlZCBkb2N1bWVudGF0aW9uIGZvciBhCm5ldyBkZXZlbG9wbWVudCB0b29sLiBKb24g
dmVyeSByZWFzb25hYmx5IHN1Z2dlc3RlZCBpdCBzaG91bGQgZ28gaW4KRG9jdW1lbnRhdGlvbi9k
ZXYtdG9vbHMvLCB3aGljaCBpcyBub3QgdmVyeSB3ZWxsIG9yZ2FuaXplZC4gVGhpcyBpbgp0dXJu
IHByb21wdGVkIGEgZGlzY3Vzc2lvbiBhYm91dCBjbGVhbmluZyBpdCB1cC4KCj4gQnV0IHllcywg
ImtpbmQgb2YgdGhyb3duIHRvZ2V0aGVyIiBpcyBhIGdvb2QgZGVzY3JpcHRpb24gb2YgbXVjaCBv
Zgo+IERvY3VtZW50YXRpb24vLiAgQSBudW1iZXIgb2YgcGVvcGxlIGhhdmUgYmVlbiB3b3JraW5n
IGZvciB5ZWFycyB0byBtYWtlCj4gdGhhdCBiZXR0ZXIsIHdpdGggc29tZSBzdWNjZXNzLCBidXQg
dGhlcmUgaXMgYSBsb25nIHdheSB0byBnbyB5ZXQuICBUaGUKPiBkZXYtdG9vbHMgZGlyZWN0b3J5
IGlzIGFuIGltcHJvdmVtZW50IG92ZXIgaGF2aW5nIHRoYXQgc3R1ZmYgc2NhdHRlcmVkIGFsbAo+
IG92ZXIgdGhlIHBsYWNlIOKAlCBhdCBsZWFzdCBpdCdzIGFjdHVhbGx5IHRocm93biB0b2dldGhl
ciDigJQgYnV0IGl0J3Mgbm90IHRoZQo+IGVuZCBwb2ludC4KPgo+ID4gSXQgd291bGQgYmUgbmlj
ZSB0byBwcm92aWRlIGEgY29oZXJlbnQgb3ZlcnZpZXcsIG1heWJlIHByb3ZpZGUgc29tZQo+ID4g
YmFzaWMgZ3JvdXBpbmcgYXMgd2VsbC4KPiA+Cj4gPiBJdCB3b3VsZCBiZSBuaWNlIGlmIHRoZXJl
IHdhcyBraW5kIG9mIGEgZ2VudGxlIGludHJvZHVjdGlvbiB0byB0aGUKPiA+IHRvb2xzLCB3aGlj
aCBvbmVzIHlvdSBzaG91bGQgYmUgbG9va2luZyBhdCwgd2hlbiwgd2h5LCBldGMuCj4KPiBUb3Rh
bCBhZ3JlZW1lbnQuICBBbGwgd2UgbmVlZCBpcyBzb21lYm9keSB0byB3cml0ZSBpdCEgIDopCgpJ
IHdvdWxkbid0IG1pbmQgdGFraW5nIGEgc3RhYiBhdCBpdCBpbiBhIGxhdGVyIHBhdGNoc2V0LgoK
TXkgaW5pdGlhbCBpZGVhOiB0aGVyZSBpcyBhIGJ1bmNoIG1vcmUgc3R1ZmYgdGhhdCBuZWVkcyB0
byBiZSBhZGRlZApoZXJlLCBzbyBwcm9iYWJseSBkb24ndCB3YW50IHRvIGRvIGl0IGFsbCBhdCBv
bmNlLgoKSSBhbSB0aGlua2luZyB0aGUgZmlyc3Qgc3RlcCBpcyBqdXN0IHRvIGNhdGVnb3JpemUg
dGhpbmdzIGluIGEKc2Vuc2libGUgbWFubmVyIHNvIHNvbWVib2R5IGRvZXNuJ3QgbG9vayBhdCB0
aGUgaW5kZXggYW5kIHNlZSAqYWxsIHRoZQp0b29scyogaW1tZWRpYXRlbHkgY2F1c2luZyB0aGVp
ciBleWVzIHRvIGdsYXplIG92ZXIuIEZyb20gZmlyc3QKZ2xhbmNlcyBpdCBsb29rcyBsaWtlIHRo
ZSB1c2VycyBvZiB0aGVzZSB0b29scyBpcyBnb2luZyB0byBiZSBzb21ld2hhdApkaXNqb2ludC4K
Ck1heWJlIGJyZWFrIHRoaW5ncyBhcGFydCBieSB3aG8gYW5kIGhvdyBzb21lb25lIHdvdWxkIHVz
ZSB0aGUgdG9vbC4gRm9yIGV4YW1wbGUsCgpJdCBsb29rcyBsaWtlIENvY2NpbmVsbGUgaXMgZ29p
bmcgdG8gYmUgdXNlZCBwcmltYXJpbHkgYnkgcGVvcGxlIGRvaW5nCmNvZGUgamFuaXRvciB3b3Jr
IGFuZCBsYXJnZSBzY2FsZSBjaGFuZ2VzLgoKU3BhcnNlIHNlZW1zIGxpa2UgYSBwcmVzdWJtaXQg
dG9vbC4KCmdkYiBhbmQga2RiIGFyZSBsaWtlbHkgdXNlZCBieSBldmVyeW9uZSBmb3IgZGVidWdn
aW5nLgoKa3NlbGZ0ZXN0IChhbmQsIGlmIEkgZ2V0IG15IHdheSwgS1VuaXQpIGFyZSB1c2VkIHBy
aW1hcmlseSBwZW9wbGUKY29udHJpYnV0aW5nIG5ldyBmZWF0dXJlcyAodGhpcyBpcyBvbmUgSSBo
YXZlIG1vcmUgb2YgYSB2ZXN0ZWQKaW50ZXJlc3QgaW4sIHNvIEkgd2lsbCBsZWF2ZSBpdCBhdCB0
aGF0LCBidXQgdGhlIHBvaW50IGlzOiBJIHRoaW5rCnRoZXkgd291bGQgZ28gdG9nZXRoZXIpLgoK
TW9zdCBvZiB0aGUgcmVtYWluaW5nIHRvb2xzIChleGNlcHQgZ2NvdikgbG9vayBsaWtlIHRoZSBr
aW5kIG9mIGxvbmcKcnVubmluZyB0ZXN0cyB0aGF0IHlvdSBwb2ludCBhdCBhIHN0YWJsZSB0cmVl
IGFuZCBsZXQgaXQgc2l0IGFuZCBjYXRjaApidWdzLiBTdXBlciB1c2VmdWwsIGJ1dCBJIGRvbid0
IHRoaW5rIHlvdXIgYXZlcmFnZSBrZXJuZWwgZGV2IGlzIGdvaW5nCnRvIGJlIHRyeWluZyB0byBz
ZXQgaXQgdXAgb3IgcnVuIGl0LiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLgoKU28g
dGhhdCBsZWF2ZXMgZ2Nvdi4gSSB0aGluayBpdCBpcyBhd2Vzb21lLCBidXQgSSBhbSBub3Qgc3Vy
ZSBob3cgdG8KY2F0ZWdvcml6ZSBpdC4gRGVmaW5pdGVseSB3YW50IHNvbWUgYWR2aWNlIGhlcmUu
CgpPbmNlIGV2ZXJ5dGhpbmcgaXMgYXBwcm9wcmlhdGVseSBjYXRlZ29yaXplZCBieSBzaGFwZSwg
aW4gKGEpCnN1YnNlcXVlbnQgcGF0Y2hzZXQocykgd2UgY2FuIHRpZSBlYWNoIG9uZSBpbiB3aXRo
IGEgZ3VpZGUsIG5vdCBqdXN0Cm9uIGhvdyB0byB1c2UgdGhlIHRvb2wsIGJ1dCBob3cgdGhlIHdv
cmtmbG93IGxvb2tzIGZvciBzb21lb25lIHdobwp1c2VzIHRoYXQgdG9vbC4gRm9yIGV4YW1wbGUs
IHdlIG1pZ2h0IHdhbnQgdG8gYSBndWlkZSBvbiBob3cgdG8gZG8KbGFyZ2Ugc2NhbGUgY2hhbmdl
cyBpbiB0aGUgTGludXgga2VybmVsIGFuZCBoYXZlIHRoYXQgdGllIGluIHdpdGgKQ29jY2luZWxs
ZS4gRm9yIGtzZWxmdGVzdCBhbmQgS1VuaXQsIHdlIG1pZ2h0IHdhbnQgdG8gcHJvdmlkZSBhIGd1
aWRlCm9uIGhvdyB0byB0ZXN0IExpbnV4IGtlcm5lbCBjb2RlLCB3aGljaCB3b3VsZCBjb3ZlciB3
aGVuIGFuZCBob3cgdG8KdXNlIGVhY2guCgpBbnl3YXksIGp1c3QgYSB2YWd1ZSBza2V0Y2guIExv
b2tpbmcgZm9yd2FyZCB0byBoZWFyIHdoYXQgZXZlcnlvbmUgdGhpbmtzIQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udmRpbW0K
