Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADAB160C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 23:58:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BBBC202E6E06;
	Thu, 12 Sep 2019 14:58:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E5DA5202E2919
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 14:58:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t8so20533159lfc.13
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yN64USJBHKxsfREIuBd8D01a5UImJnKtWKpzPkFiizg=;
 b=PGW6zE4wNxxbjukTtRMTx8QNmVGcBEm2hLEbRkWw3oXK9nosmOY/buL4Xg57qP7S6J
 hRKk5uMe62EFQnvCvGdpsQIO5VfARhpFMvQBS9xjkfCFbqRsSvDw8KqqDB15n+yYeLBn
 zPxoy5clxY4UDz73h1hZC/niCSMsEOmI6A5RJaept57woKtYBCfsKB5hBWKo4ZbgQrWw
 EB20B8PyGGMZr6eYzQkz5kJ9NI6NBrd1D9O0D29B1H94HFsPeO14NBzRgYFMpa8+6fXq
 zJk3j/7eXO93uB2VhFrcsr0AwzLy+U0ZI1QJ6qUYEUcccgf0rmiNtji2b9kK7Sq1AnvZ
 jG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yN64USJBHKxsfREIuBd8D01a5UImJnKtWKpzPkFiizg=;
 b=GvTNRvQuy3IBtGrsQi/HEjbYw6ix5tpKbWbPhth1PDbgChOambZe1vcovsXsTqjIbF
 obeABcV4E/ahNEgVSoTIsVVt7FxME5c4qCqJmUh799SO9zh3PqDXlA23PvYtqlOm0ze6
 47ssr0bS9u/JzqSHrMx6BOyFuR2kgtt5glCM/sxtGLnEdV/RZylzMN74z5CmbWn7kwCe
 BFq9XmqrCxPsp03U5t3MqonrSCZe47HZOLIhwvpHeHhRj0FGvJO9Vfd+QIH5GxH5FkjP
 zWrsUmhP94tnUbKVpfATFmxxTt6l5ASw2bxz7XozJ2yr3NwIWk2Bel49HTyGSCBTDAS6
 2SrQ==
X-Gm-Message-State: APjAAAXZmj7YUGiXiiCoglJZE0q4tTXNrvS90zsjsm2QYWThP7TZovR3
 QqL536mGUlZGLUOnjVBDjquF5WEgDCIafu7m57k=
X-Google-Smtp-Source: APXvYqx/qjsJazNB675gWGR/Z07snhq12vp75Kg6Qq3NQ2rBGj/WnqBglk8w5SZZbbo9fLzY24rbLzt+aQGVznyXfUU=
X-Received: by 2002:a19:428f:: with SMTP id
 p137mr29623982lfa.149.1568325518795; 
 Thu, 12 Sep 2019 14:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
 <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
In-Reply-To: <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Sep 2019 23:58:27 +0200
Message-ID: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To: Joe Perches <joe@perches.com>, Nick Desaulniers <ndesaulniers@google.com>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
>
> Please name the major projects and then point to their
> .clang-format equivalents.
>
> Also note the size/scope/complexity of the major projects.

Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
with the official clang-format, not sure if they enforce it.

Same for Chromium/Chrome, but it looks like they indeed enforce it:

  "A checkout should give you clang-format to automatically format C++
code. By policy, Clang's formatting of code should always be accepted
in code reviews."

I would bet other Google projects do so as well (since Chandler
Carruth has been giving talks about clang-format for 7+ years). Nick?

I hope those are major enough. There is also precedent in other
languages (e.g. Java, C#, Rust).

> I used the latest one, and quite a bit of the conversion
> was unpleasant to read.

It would be good to see particularly bad snippets to see if we can do
something about them (and, if needed, try to improve clang-format to
support whatever we need).

Did you tweak the parameters with the new ones? I am preparing an RFC
patch for an updated .clang-format configuration that improves quite a
bit the results w.r.t. to the current one (and allows for some leeway
on the developer's side, which helps prevent some cases too).

> Marking sections _no_auto_format_ isn't really a
> good solution is it?

I am thinking about special tables that are hand-crafted or very
complex macros. For those, yes, I think it is a fine solution. That is
why clang-format has that feature to begin with, and you can see an
example in Mozilla's style guide which points here:

  https://github.com/mozilla/gecko-dev/blob/master/xpcom/io/nsEscape.cpp#L22

Cheers,
Miguel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
