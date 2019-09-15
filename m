Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34FB3157
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Sep 2019 20:25:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8DC8A21A00AE6;
	Sun, 15 Sep 2019 11:25:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3A9E620277236
 for <linux-nvdimm@lists.01.org>; Sun, 15 Sep 2019 11:25:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c195so10814786lfg.9
 for <linux-nvdimm@lists.01.org>; Sun, 15 Sep 2019 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dbnIhtM2BKG6IYVDdOCp6G8vpQKdSMQTGQ4f3pGk7vs=;
 b=rd8EsNf9yf0dbuq9g/TOSPhliI7d5mEgLIU6opvAUyXGQMgiDsdhhlM5NPYE4fx4fV
 1oIdwGiYWhlCrYOTnrtb9KqomL1oZuScESRZ2MCh/0i4A9dsY3NTv4oKmBhcBEZf9oYn
 l2awC19NQnKyP2X4nyreahL+qcvbxKzIwPPwfurn4sgESw4OpLCUT9SZowM4Ys9RChKO
 FeK/6/MJ+iT9QD3ZFQ85VXaXXp5wbMSQU9sKjCI//9gHJVJwONQlxeBuTzDLAUdIjfbq
 5Nu8HSKS1g6PT01zTy6vWgPv6BYBOI4cZnO+nLVNgPNTjeubShzLmv1gaAmvN2Rk7xWl
 IqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dbnIhtM2BKG6IYVDdOCp6G8vpQKdSMQTGQ4f3pGk7vs=;
 b=nOE0wjNRbzmbOdsj8DowgZXC0cvo8a4pRH+2lO1PKLuSrpfABZ9iTdS7Ve5YqFdF60
 uWCGM/nb/DLHbRy3eloEQHGKV7ZBnfQEVxkOp/NHjzhC4Fc66oLVcuf0kCGCYujD27rx
 rGiHxDd5YBcLv+QTohqDEwDlROZZiUKkYl+trxG8h3VtorZ4SrRt7N2surrSU5X7WP3w
 s09tsK4KumaF0f9/Wq1zWWIdGD0ChmnFnmqFAa5g+mur3wvQ5v73HOez31DDGaZDZ0UK
 4v0rXYPV0yuZnuUDOX1+ynLFXmRZ1AuKF1cYSrfNBphLQJAUHKsw4k6hc5ZgVpkN4Xii
 tqWg==
X-Gm-Message-State: APjAAAWwF82OSCCoUkILz6BEqnEh4AuCcIjlp/AMaWmjAJNfVDxfSpE1
 PZdlrloFUlHvcb4DSi83epNewE1f/GSC39ShCtM=
X-Google-Smtp-Source: APXvYqxt2+mQ3NuxseYtTtkITEVZZpuRJghHl2BxfXJUF7jA0peoLYvGXe4n93Y8vVqBjwX5kP69Ez9EJwBWCgqQPdI=
X-Received: by 2002:ac2:4902:: with SMTP id n2mr37085890lfi.0.1568571952132;
 Sun, 15 Sep 2019 11:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
 <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
 <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
 <fdd69f54908d90cd0c93af7b5d80a6c3ca3b5817.camel@perches.com>
In-Reply-To: <fdd69f54908d90cd0c93af7b5d80a6c3ca3b5817.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Sep 2019 20:25:41 +0200
Message-ID: <CANiq72=H+1HGur2vJUxZmpZPbqbm5s8C1CTFwHgciTPeNFTFTA@mail.gmail.com>
Subject: Re: clang-format and 'clang-format on' and 'clang-format off'
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, llvm-dev@lists.llvm.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 13, 2019 at 1:26 AM Joe Perches <joe@perches.com> wrote:
>
> Not every project is going to use only the clang-format tool.

Why? The end goal would be to enforce all code to be running under the
same formatting rules (which, in practice, means the same tool at the
moment).

Note that you can use clang-format with most editors (including vim,
emacs, VS, VSCode, XCode, Sublime, Atom...).

Cheers,
Miguel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
