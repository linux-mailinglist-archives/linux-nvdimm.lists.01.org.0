Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A463B1687
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 01:01:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A505D202E6E16;
	Thu, 12 Sep 2019 16:01:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=ndesaulniers@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B1B69202E6E11
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 16:01:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d15so16862265pfo.10
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9dYUr5fMgUHKFTaUbiggMwqfm0d4ExFNXTKQwvsDKQ=;
 b=tPvXqEzHwKpENKEwHi+Skg0ISMB7ZFeB0yn6fEGDuRS61LxsjWdYrvLH7BObaVO3QB
 HsxMdXR+4aWWSfV+ANxcz0Bo0o3+m1Wv1IeRZJ5ymFd5GGiMrSTqBjgZv9EPPdkoVJoE
 nsaxTy4G3QnB9ClFNIRybTH9QlrNg8MIH4HJi8Gn1ORBp28GWQy/T1ZOBztKGGQNSQSA
 ZBmziZ1luIwLyXBh+aJj+Tq+k2YA2w1JufIQ425tRqxHmpOft3Fbk/nIN7Prdjv2GtT2
 eUCpew0OAlYYRdqQ9LTbf1aHAnRjHKtThgj8M46igFVG7H7c4gheoHjP36DfQhsOIKgA
 1F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D9dYUr5fMgUHKFTaUbiggMwqfm0d4ExFNXTKQwvsDKQ=;
 b=mXfe0iNUDmjNVhu/TG7EstzDT7O6xGAEY5rBeeuhi4+TetdcQmk8AD8S5Q93Qxe1gH
 niKKOWgz104j3sdA4W7QWlG8iLGNKniFWlF0FfV48wv1ssaub+nNxts2/gtef2IE1uXQ
 W85+96bTWZjYbuf/mXu/+AUJG9DnR4+BXwBgap/9mV9Eu4tjqzfHVqq0UzbZgAd27YBl
 43iah8fib83Mk75aQQ9Y2kO/0dRP/aIeFknmrS/0Bvs/Z7M4NLgWeAdh5WWdS+qa8Bup
 08mi95YtuyVpcE7nDAr8atKjGbe8NpY9rorc48F3gReTtAtiW9SC5FOcyJPEfUxYXchS
 MzvA==
X-Gm-Message-State: APjAAAVVPBHr0IJ3fs9Sl1u/m+/V0CTNvKcqdL9Rrxhm0/slkhvK2am7
 0UTD8FBKyb5ATgLV/gWWubNuelf7JGo81gj/sT53Ag==
X-Google-Smtp-Source: APXvYqxKPqcf3nesXiRdlItW9fzTGtoWDpjNQ9SjjFM/YxRP0tFmd4/ksEvcvMhaZFyTL+zMR5XBadhwoqkrNWZwEyE=
X-Received: by 2002:a63:6193:: with SMTP id
 v141mr41159638pgb.263.1568329264856; 
 Thu, 12 Sep 2019 16:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
 <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
 <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
 <4f759f8c4f4d59fd60008e833334e29b0da0869c.camel@perches.com>
In-Reply-To: <4f759f8c4f4d59fd60008e833334e29b0da0869c.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 12 Sep 2019 16:00:53 -0700
Message-ID: <CAKwvOd=S911qkQtN31JkusS==NXZMnEwrUOGN3Gp6B7GTzYe2A@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To: Joe Perches <joe@perches.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 3:38 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-09-12 at 23:58 +0200, Miguel Ojeda wrote:
> > On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> > > Please name the major projects and then point to their
> > > .clang-format equivalents.
> > >
> > > Also note the size/scope/complexity of the major projects.
> >
> > Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> > with the official clang-format, not sure if they enforce it.
>
> At least for LLVM, it appears not.

I acknowledge the irony you present, but that's because there's no
enforcement on the LLVM side.  I frequently forget to run:
$ git-clang-format HEAD~

If you have automated systems that help encourage (ie. force) the use
of the formatter, this helps.

Consider the fact that not all kernel developers run checkpatch.pl.
Is that a deficiency in checkpatch.pl, or the lack of enforcement in
kernel developers' workflows?
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
