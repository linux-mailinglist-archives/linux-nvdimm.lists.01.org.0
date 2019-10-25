Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32EE5693
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 00:45:49 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 913E0100EA600;
	Fri, 25 Oct 2019 15:46:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 30DCA100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 15:46:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y39so308674qty.0
        for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DYywa8gONdexolDcaR4V0aX/JK63D5OgCkX4AmxYjM=;
        b=I0aloD8xas/075MWzchVZHS0wcDNzZnYmgSqnSVwoh6XglP1H5IIloMzB6c/VVfkjt
         I9b0mN0tuuXtua87BfCpt4l7cJlJAurRikm7ONSk9LwLkEgHrhCONdV/QRZ6TYqlBC7b
         KqvfixMs3DBdd8K6qZoRwBnzYgGbgeI8eo7iSPTL1wJJ+Z7kNfkQ+dJhuARHYvaEreQH
         b8g3REB4sn2z5R5HaMXvW2dQZOadlP9Ia/TLFBYOW3KhW4tYQcclDurwovbWhJVe/VJT
         mN4kfjK/D0jLvg1P19r91OJWmnlpXMc6LGqdDzto59BK/TZpsltWYDq57ksdJmhmsE/q
         y4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DYywa8gONdexolDcaR4V0aX/JK63D5OgCkX4AmxYjM=;
        b=meQqTSzWZwWvvoRuWjzl4dsFm7DKZy7URwHUFwO7df3AmaTsq2H+zdhKlCb+zQeSBX
         Ql0nF3U9JBAEcS0NWZnzFer+BTGrebGnu1GsYJxfEaOxBz7UTxoCMYvKfr3r2jaMOAuv
         NChvYntprXuhdWqZErdTAwTrc/wnBy6NUX59aHPs2ngu6C+fuf3uuR6eBrmkvyVB8YLD
         vhJDEEo07qcaKib+jpcvRAzlO025IYteJ5572Vi2rrCoMbjQdpPBnzoC9MhbG4qc1e/k
         PuT/XZuhfmt2IgfPwl9gD7z8KH5HFWIYR7G07QuXx4CWPL6H9Iq08ItSHYTWBWZFFBx2
         WDIw==
X-Gm-Message-State: APjAAAUhhLdyisw0HoGwEfN0yt41OVRgyqk4jBigG/M3jfpn7keBti8V
	P+/6zrR1EW4CjMyN3ZkzZhKXQdmV7p1JfkRh/4Ef9g==
X-Google-Smtp-Source: APXvYqzy7VtFTfrpPLjnQlO6ySEwY9RkrlXI8yizPrLMlhzT28dBaqq8uErfsoVFeBdn1EAHmE3bhLbMtWcD/J+SLo0=
X-Received: by 2002:ac8:4241:: with SMTP id r1mr5773124qtm.111.1572043544756;
 Fri, 25 Oct 2019 15:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
In-Reply-To: <20191025175553.63271-1-d.scott.phillips@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Oct 2019 15:45:33 -0700
Message-ID: <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
To: D Scott Phillips <d.scott.phillips@intel.com>
Message-ID-Hash: NKTR4N5NVXFVDIJ2IK2D4QDT3D5WPELX
X-Message-ID-Hash: NKTR4N5NVXFVDIJ2IK2D4QDT3D5WPELX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Howells <dhowells@redhat.com>, stuart hayes <stuart.w.hayes@gmail.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKTR4N5NVXFVDIJ2IK2D4QDT3D5WPELX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 25, 2019 at 10:55 AM D Scott Phillips
<d.scott.phillips@intel.com> wrote:
>
> Allow ndctl.h to be licensed with BSD-2-Clause so that other
> operating systems can provide the same user level interface.
> ---
>
> I've been working on nvdimm support in FreeBSD and would like to
> offer the same ndctl API there to ease porting of application
> code. Here I'm proposing to add the BSD-2-Clause license to this
> header file, so that it can later be copied into FreeBSD.
>
> I believe that all the authors of changes to this file (in the To:
> list) would need to agree to this change before it could be
> accepted, so any signed-off-by is intentionally ommited for now.
> Thanks,

I have no problem with this change, but let's take the opportunity to
let SPDX do its job and drop the full license text.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
