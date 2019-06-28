Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72385A0FC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 18:32:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 535DC212AB4EC;
	Fri, 28 Jun 2019 09:32:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1809E212AB4DE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:32:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w79so4699285oif.10
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DSSGw8NEH11ewDdufk/0bURDdPjPPEZM8INGXLUnbI4=;
 b=UnRnfO0Nkq0CWLy0+jnDM8ue7U956sKozY+AKoPt5xRTIRRw6jIBvwQFZkI8xtiY7l
 bn5QpKa/NwVVD/pzCkjRzlhwk7NyOe2D2TKYDVR0YHpUx+sRdCvEqqY44do86XDzWfLx
 XfWTtUhAU8VqhOwhesKkvAgbJb83oJXyq/rK/aUyL2ErWSKQ6Xxk74bZsh9+wV5pJLj4
 fRPeMkH08JPr+B4SWknFZnL81j2AE0gCsftdycEsCOqC+3DPt4F3qdoRXs8mXU5CoqC+
 GTCP4pL7SsstbHnRYi6+AKdXAib6v9FqeSbLi5gJDoFvHqzgvrQYghU6hOGYbYqO5aCE
 7iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DSSGw8NEH11ewDdufk/0bURDdPjPPEZM8INGXLUnbI4=;
 b=O4fvdxiZx+vlje5p7DhC5zysR/Ba3skikZxk4vzdPfgwK368tCllQUgtPa8uq2wH5+
 ujUZU6D8ng7EVFZh5W2oAw0Kv3Pho7AjbemjDmUP1gogXRbWkgM6Pou0AfKvWXBnidIe
 ++hIHuRlGQQ1s2kn6LKRq9mTnAKDlOpgiK1fjUlo9F6rYK6w6SDyIqxSFXL1/VtvsUZC
 JfT4v5vPp/NFhKssaHoeuVucfO7k5cW1txCJ8snkOpDknE6GxuWfjFcDkl2lds37vy9w
 CIgsvOfH1QWtPL7tUhufODkJk5kp1GZCNrG/DDiXvOFve03NGnZqgvNxhn/TlDKosujb
 ThnQ==
X-Gm-Message-State: APjAAAXAYCGvPZ5zONQWsLmlaQYbZpp+Kd6PmPbqyecAMqix1BBqHiE6
 jmAnCTNJdpNirL9HnImBrG/AHTkRXPqgFvyFypwShQ==
X-Google-Smtp-Source: APXvYqxih5y3ClRM05oqB9q9VPsU0VTaOI1Z60yEi/NkQKAhhvUNxdezdMDupWBvEeRdmvEWNaxGW0AWHHTUwFYwhGw=
X-Received: by 2002:aca:1304:: with SMTP id e4mr2181365oii.149.1561739560073; 
 Fri, 28 Jun 2019 09:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
 <951fdc9197ffd04cf77168d47685e1299f7d9d73.1561723980.git.mchehab+samsung@kernel.org>
In-Reply-To: <951fdc9197ffd04cf77168d47685e1299f7d9d73.1561723980.git.mchehab+samsung@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 09:32:29 -0700
Message-ID: <CAPcyv4jnz+Cz4sXEDHPiX77BV1piBkbh7LHgs-rUf39NAB7_gw@mail.gmail.com>
Subject: Re: [PATCH 30/43] docs: nvdimm: convert to ReST
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

On Fri, Jun 28, 2019 at 5:21 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Rename the nvdimm documentation files to ReST, add an
> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
