Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713871FB76
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 22:26:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D4922126CF92;
	Wed, 15 May 2019 13:26:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7280621268F9E
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 13:26:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v10so827317oib.1
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CNowSPd6xUM0oSrW52wC5X6N9h9RHW9ouHTqZZOyPB4=;
 b=SAIOuCey/H4PDGjItNH6MJbpdQ6eVphhRbi02FoQ/YOnoYGxaydqsOYiVIAO/t3q68
 0i+LFQ13vsz1bj8cCiXxLi+GMY0PpVS/n4Tnm/fMII2aHygPYzSJnwoWDtPiIo9XVU4B
 UF+xwmZUZQ0W+oJace3RMwVkn3Iuq8GIugGZdBu4qRRMMPgZWHzuG5COUhU0vp87nTs/
 FG1JFG1PtJ3RikGbUfL/NJErfucnwOSQDnoR242LrP2jVHyNv6FXHEZUgTRCbyr9ydcG
 Lyzzv47sX90bEqpeR7WfOo7msFCsrbGa0h1IuogufITOeuGE2XDwd6+gyOeGA8Z7o+W9
 OqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CNowSPd6xUM0oSrW52wC5X6N9h9RHW9ouHTqZZOyPB4=;
 b=TV/VuXA4eCz2qzgpACNkk4cdJBvGJUWwdIe4NAKakYSK3pHl/A6H57YVqKEMMpJGOw
 yBYLTXdKoGIZDIa+hkWJ0NpgJs9ahsC5ko63iwod1e4eXDu2tdZ1wkBgBml8MTNtSNBy
 jIS5dpvGtGIg5K+gr5M9T2n2vUDDyFzIbcKUmzhSB/PNOIVDtL1+dzRYxeTlDjFba4nt
 AYJAzRLya5F2OleWPpe2w5FpQIMP5J+AlOEStiWOQrfwhU/cCDc7R7mkgDM3CLnzNngI
 w6XYMKJc4465Ie+ze+CUI4My9wEuKVEuss0ljui4rvp2XFts4HUd0ACKjM9lA7ET+Nwp
 AjpA==
X-Gm-Message-State: APjAAAU7AglM6tYkFDVuR7diBTzhce2RFlR+Grx6kjwdSNNuNOoUBijS
 rHkQhAf3RhMJFXlApZ4hc6leAtLOUzPBhDbTJ1vP0w==
X-Google-Smtp-Source: APXvYqx3oc7K1TBy0FDWKi5FhWmRYToljSQrlPDbQpttbtlguEoDEhZRGEYR3NAHlPXP6/3HQG4xvypvNp6sEKcLSAk=
X-Received: by 2002:aca:4208:: with SMTP id p8mr8481558oia.105.1557951987781; 
 Wed, 15 May 2019 13:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
 <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
 <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
 <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com>
 <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 13:26:16 -0700
Message-ID: <CAPcyv4g+reM9y+CiGXpxBYMQZ-Yh4LuXDi2530FR0zt3o6J8Hg@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Cc: "Luck, Tony" <tony.luck@intel.com>, Dave Hansen <dave.hansen@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Mar 11, 2019 at 5:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 11, 2019 at 8:37 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Another feature the userspace tooling can support for the PMEM as RAM
> > case is the ability to complete an Address Range Scrub of the range
> > before it is added to the core-mm. I.e at least ensure that previously
> > encountered poison is eliminated.
>
> Ok, so this at least makes sense as an argument to me.
>
> In the "PMEM as filesystem" part, the errors have long-term history,
> while in "PMEM as RAM" the memory may be physically the same thing,
> but it doesn't have the history and as such may not be prone to
> long-term errors the same way.
>
> So that validly argues that yes, when used as RAM, the likelihood for
> errors is much lower because they don't accumulate the same way.

In case anyone is looking for the above mentioned tooling for use with
the v5.1 kernel, Vishal has released ndctl-v65 with the new
"clear-errors" command [1].

[1]: https://pmem.io/ndctl/ndctl-clear-errors.html
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
