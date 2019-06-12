Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4242F77
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 21:04:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 107E521A02937;
	Wed, 12 Jun 2019 12:04:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 269C2211F9D6B
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 12:04:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s20so2178228otp.4
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fm+mSktMwQOzdmDjQttzxop/Se9urlLSubyC93GJpJ4=;
 b=LuS7gSaW0BGRMk1yfudUHtAoBYQKvzFNUXxlwVYlUwgLqve/5odOm96fueOy+dk3wr
 JnCiH0mwRbkEKhYD/7ByaJvEVvjj8dH87169XEup7OtRPolTcWrSxYG6e7VXkVvpJGRv
 i5nX7zOQlFCF5BNAJfa/lM72KUtF+3Uciofl+omm6sZ9CouKcHFPCV5P8xf0VbWwOwFt
 /woNTQkJ63ZEwhtinkhqDXqjZT7SafFqxlRydcZSgojOlxu/sZug3q+uoerJmx3Zg3p2
 +N/1xX+vYJB3A/GuFz8kc7M9zhPlE2hJTAEsNRMWc6lHVEsqlD5vPB6vXjqrwyHo5DUT
 Xpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fm+mSktMwQOzdmDjQttzxop/Se9urlLSubyC93GJpJ4=;
 b=IdBVrW1PCo9FDsSw1JugtwxkSbmcIhInWDdr/CZ6CfXD4ELehj2oeDlgN/NFa+ka35
 krG1vH+IZwGnFqkciY0U0EMx44JDC5Cx4HIRxQ/s7heRBtEGKPJGZD93PZBJYRSYbidC
 f5pK/+GKBjkEz6Oc8h9NeaiFqX5/4EXZNrB9qY00fp+f3JHrWD9MLAMMDxEcVaR3yCzN
 n9RYNm88E0d4MCu4tHsIzoQpErWzZEuxFenwHStEmLjbnNWvI3OKKkTxRZJNi+nKS/AQ
 t8uNcVDEw4ugTQ1XdncEQ5mAEePnAczzTxGhER5hheUc+3oK9HQl0LAzdl6YvxaMTZH5
 cR+A==
X-Gm-Message-State: APjAAAUMY/xDWN8HLUacLGnHpC0BeoUU1oYGWhUHTA1gIDMNHhvtlG9O
 KNfYrnFbubpLvsf8tGOq1So0trsv+ghlsMUT11iGdA==
X-Google-Smtp-Source: APXvYqxvJTu577fQoKcjkYpWtOb5YYd/YL44ZHZzH9wLurkBS4Udi6HfEgZVwQ1tDKxNk2V77DLY+1ueAa7R3cyNUO0=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr9613478otk.363.1560366263877; 
 Wed, 12 Jun 2019 12:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
 <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
In-Reply-To: <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Jun 2019 12:04:12 -0700
Message-ID: <CAPcyv4g08r6bK_SyTjzKFRM7=wpTQLdmHqRSGh7r-e9YD4tq5Q@mail.gmail.com>
Subject: Re: [PATCH v1 29/31] docs: nvdimm: convert to ReST
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Mauro,

On Wed, Jun 12, 2019 at 11:38 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Rename the mtd documentation files to ReST, add an

s/mtd/nvdimm/

> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.

Looks ok, but I was not able to apply this one in isolation to give it
a try. Am I missing some pre-reqs compared to v5.2-rc4?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
