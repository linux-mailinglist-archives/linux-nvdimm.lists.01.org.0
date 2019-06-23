Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F174FE37
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 00:09:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C32BB212966F4;
	Sun, 23 Jun 2019 15:09:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=swanson@eng.ucsd.edu; receiver=linux-nvdimm@lists.01.org 
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5237421281EE5
 for <linux-nvdimm@lists.01.org>; Sun, 23 Jun 2019 15:09:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a25so8577629lfg.2
 for <linux-nvdimm@lists.01.org>; Sun, 23 Jun 2019 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eng.ucsd.edu; s=google;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=fWua/YqS4FEljrievWChxWON81LwIdhrq3+jjioZzeU=;
 b=XRzekx12x2R8BEza9NPZGwIGOrPwswPbQRhDWoOLF3Yfpx/jrUbZUbgCDaQ1lWFtcc
 3S8GL5iLJsMPb0EPOjtDLGuDxfLsEUbaCwp8/WB72LPvX/Fv0JqSqU1xsxhmqvu54VR+
 oO21ddEIYT5zCq2CRR74hE5nz4XimDWYTnIgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=fWua/YqS4FEljrievWChxWON81LwIdhrq3+jjioZzeU=;
 b=ggujrWPGHMFhv1yAE7QOwtIoe48wFByscZ6NIV0c2qYrP1mRSw930D5yEkza2t8VjK
 9QA8u/Dwc1cyWrO7ff/H/2NIrBBKAaMlPh/kgJIdmX/r5e3zlHe5tVcZ69FeDUxIN32D
 w3q8avaiGEt5OHqxkSt+t88D/GuW2MuCJ8ryRM5UchZEe4iouC9uq95UgGJr9zYCFeNX
 eCD02tsR7NX4Ksdi1NDbUzuWZyFpmgKHSlEfbm4GY5I5Xv1o+ib3davfN650Yqzou+Y0
 klyGbd4v/hGdA+xN3e4RY12snIbH99AWbvIfESXACy8iKgyJEpNxRkswXXzuUupx54pz
 g2KQ==
X-Gm-Message-State: APjAAAUkTGYD7I3Wbu3eNOJThoYgm4hoLFlRVFXxpGBzl6knh0LhBIv3
 ZE7aC7T5yZ4yhMzg5jCnEogkNO7SjLic4yZg5AH76LU1TEg=
X-Google-Smtp-Source: APXvYqw5GB8w+Rr7ZCSldCfQW9Z++tyCAuBFim39MNoH6h0Nz9D6axObPB4rzu6i0my/bgVMZFoWONlA3soFypmx88s=
X-Received: by 2002:a19:230f:: with SMTP id j15mr35109270lfj.122.1561327778613; 
 Sun, 23 Jun 2019 15:09:38 -0700 (PDT)
MIME-Version: 1.0
From: Steven Swanson <swanson@eng.ucsd.edu>
Date: Sun, 23 Jun 2019 15:09:27 -0700
Message-ID: <CABjYnA7JXEwoxyE+2QisupAQuG0YJ3GUY24QooqY3vAZoFZOLg@mail.gmail.com>
Subject: Call for participation: Persistent Programming In Real Life
To: linux-nvdimm <linux-nvdimm@lists.01.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

WW91IGFyZSBpbnZpdGVkIHRvIGF0dGVuZCB0aGUgZmlyc3QgYW5udWFsIFBlcnNpc3RlbnQgUHJv
Z3JhbW1pbmcgaW4KUmVhbCBMaWZlIChQSVJMKSBtZWV0aW5nIChodHRwczovL3BpcmwubnZzbC5p
by8pLiAgUElSTCBicmluZ3MKdG9nZXRoZXIgc29mdHdhcmUgZGV2ZWxvcG1lbnQgbGVhZGVycyBp
bnRlcmVzdGVkIGluIGxlYXJuaW5nIGFib3V0CnByb2dyYW1taW5nIG1ldGhvZG9sb2dpZXMgZm9y
IHBlcnNpc3RlbnQgbWVtb3JpZXMgKGUuZy4gTlZESU1NcywKT3B0YW5lIERDKSBhbmQgc2hhcmlu
ZyB0aGVpciBleHBlcmllbmNlcyB3aXRoIG90aGVycy4gIFRoaXMgaXMgYQptZWV0aW5nIGZvciBk
ZXZlbG9wZXIgcHJvamVjdCBsZWFkcyBvbiB0aGUgZnJvbnQgbGluZXMgb2YgcGVyc2lzdGVudApw
cm9ncmFtbWluZywgbm90IHNhbGVzLCBtYXJrZXRpbmcsIG9yIG5vbi10ZWNobmljYWwgbWFuYWdl
bWVudC4KClBJUkwgZmVhdHVyZXMgYSBwcm9ncmFtIG9mIDE4IHByZXNlbnRhdGlvbnMgYW5kIDUg
a2V5bm90ZXMgZnJvbQppbmR1c3RyeS1sZWFkaW5nIGRldmVsb3BlcnMgd2hvIGhhdmUgYnVpbHQg
cmVhbCBzeXN0ZW1zIHVzaW5nCnBlcnNpc3RlbnQgbWVtb3J5LiAgVGhleSB3aWxsIHNoYXJlIHdo
YXQgdGhleSBoYXZlIGRvbmUgKGFuZCB3YW50IHRvCmRvKSB3aXRoIHBlcnNpc3RlbnQgbWVtb3J5
LCB3aGF0IHdvcmtlZCwgd2hhdCBkaWRu4oCZdCwgd2hhdCB3YXMgaGFyZCwKd2hhdCB3YXMgZWFz
eSwgd2hhdCB3YXMgc3VycHJpc2luZywgYW5kIHdoYXQgdGhleSBsZWFybmVkLgoKVGhpcyB5ZWFy
4oCZcyBrZXlub3RlIHByZXNlbnRhdGlvbnMgd2lsbCBiZToKCiogUHJhdGFwIFN1YnJhaG1hbnlh
bSAoVm13YXJlKTogUHJvZ3JhbW1pbmcgUGVyc2lzdGVudCBNZW1vcnkgSW4gQQpWaXJ0dWFsaXpl
ZCBFbnZpcm9ubWVudCBVc2luZyBHb2xhbmcKKiBadW95dSBUYW8gKE9yYWNsZSk6IEV4YWRhdGEg
V2l0aCBQZXJzaXN0ZW50IE1lbW9yeSDigJMgQW4gRXBpYyBKb3VybmV5CiogRGFuIFdpbGxpYW1z
IChJbnRlbCBDb3Jwb3JhdGlvbik6IFRoZSAzcmQgUmFpbCBPZiBMaW51eCBGaWxlc3lzdGVtczoK
QSBTdXJ2aXZhbCBTdG9yeQoqIFN0ZXBoZW4gQmF0ZXMgKEVpZGV0aWNvbSk6IFN1Y2Nlc3NmdWxs
eSBEZXBsb3lpbmcgUGVyc2lzdGVudCBNZW1vcnkKQW5kIEFjY2VsZXJhdGlvbiBWaWEgQ29tcHV0
ZSBFeHByZXNzIExpbmsKKiBTY290dCBNaWxsZXIgKERyZWFtd29ya3MpOiBQZXJzaXN0ZW50IE1l
bW9yeSBJbiBGZWF0dXJlIEFuaW1hdGlvbiBQcm9kdWN0aW9uCgpPdGhlciBzcGVha2VycyBpbmNs
dWRlIGVuZ2luZWVycyBmcm9tIE5ldEFwcCwgTGF3cmVuY2UgTGl2ZXJtb3JlCk5hdGlvbmFsIExh
Ym9yYXRvcnksIE9yYWNsZSwgU2FuZGlhIE5hdGlvbmFsIExhYnMsIEludGVsLCBTQVAsIFJlZGhh
dCwKYW5kIHVuaXZlcnNpdGllcyBmcm9tIGFyb3VuZCB0aGUgd29ybGQuICBGdWxsIERldGFpbHMg
YXJlIGF2YWlsYWJsZSBhdAp0aGUgUElSTCBXZWJzaXRlOiBodHRwczovL3BpcmwubnZzbC5pby8u
CgpQSVJMIHdpbGwgYmUgaGVsZCBvbiB0aGUgVW5pdmVyc2l0eSBvZiBDYWxpZm9ybmlhLCBTYW4g
RGllZ28gY2FtcHVzIGF0ClNjcmlwcHMgRm9ydW0sIGEgc3RhdGUtb2YtdGhlLWFydCBjb25mZXJl
bmNlIGZhY2lsaXR5IGp1c3QgYSBmZXcKbWV0ZXJzIGZyb20gdGhlIGJlYWNoLgoKUElSTCBpcyBz
bWFsbC4gIFdlIGFyZSBsaW1pdGluZyBhdHRlbmRhbmNlIHRoaXMgeWVhciB0byB1bmRlciAxMDAK
cGVvcGxlLCBpbmNsdWRpbmcgc3BlYWtlcnMuICBUaGVyZSB3aWxsIGJlIGxvdHMgb2YgdGltZSBm
b3IgaW5mb3JtYWwKZGlzY3Vzc2lvbiBhbmQgbmV0d29ya2luZy4gRWFybHkgcmVnaXN0cmF0aW9u
IGVuZHMgSnVseSAxMHRoLgoKSWYgeW91IGhhdmUgYW55IHF1ZXN0aW9ucywgcGxlYXNlIGNvbnRh
Y3QgU3RldmVuIFN3YW5zb24gKHN3YW5zb25AY3MudWNzZC5lZHUpLgoKT3JnYW5pemluZyBDb21t
aXR0ZWUKClN0ZXZlbiBTd2Fuc29uIChVQ1NEKSBKaW0gRmlzdGVyIChTTklBKSBBbmR5IFJ1ZG9m
ZiAoSW50ZWwpIEppc2hlbgpaaGFvIChVQ1NEKSBKb2UgSXpyYWVsZXZpdHogKFVDU0QpCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
