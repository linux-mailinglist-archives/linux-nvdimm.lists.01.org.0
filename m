Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59E14713
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 May 2019 11:04:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 308F22125046E;
	Mon,  6 May 2019 02:04:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 98953212108ED
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 02:04:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r136so331821oie.7
 for <linux-nvdimm@lists.01.org>; Mon, 06 May 2019 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w3CwerUbOgOXXiCSnS9RlnGeZVnQdj5otMQLyftCR5U=;
 b=e+nL3WusVlSphHxBUuOnwpeLcTbcxkM3d0tJwFVnHeQxPP67ruHIlvq20gXdKZhu2H
 bB9lDEUqhP1wiSu91mOioGKtT4ycBoUxoh4FC+hVoBp2F1BbODAaUF2mKyUrYhOAKqit
 T2YBO051njEtXYukqn8B+THQu9IDpG8A3FVKKTOi4pDJ7oz0d7KTjVHPE8z2o4ACwsE9
 ykptic7rc2BJziW9//fZQROuPUNapGoh5nZURetTsM9RFF/vX1CnGbAUdl8YpJIBiHYh
 HGrZrCbs8q8pyJ0vRF0MLBvicTMU2fCeAXdJWGTYB+VAAWlNl7nlXw7CpLz/tNO1+YWN
 PWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w3CwerUbOgOXXiCSnS9RlnGeZVnQdj5otMQLyftCR5U=;
 b=XOLYbSUmoPB9nz1xc1UJZKftipLyqI/aVv1S8kYc3/ale2SK9OOOO1Ub/gJJ+Ugr2z
 wmF0Jouppv3sfMnFz/aVddcqvOJUPeVra+uT/FtCJgV1PtJ/Ga+Opb/yyLS/twOrMvNh
 gxVTSYmvPSmtNOZHnAyxDooQ3YLnmnawD2CTA4653tGhZoyiwEVKM4R+no23obUMazuf
 Cz+H8yRe5Vbv+3CBBRT+p2F1d0OOVPkvB78fVLcViKQUnTGR89S+3ACsbD9oPTEegx7n
 hSV5r5yGbsHRzDwdn6MItAkCBPKBfcxM89G9Y5AWMnwp5dlh+7lD9pXxz6M/R/FkRYKl
 myuA==
X-Gm-Message-State: APjAAAUdkB81HLJvOdA9blBCj6T0tDK1p3m2z7mJHtJ3UsAmc7E3oqcj
 bcDMF74L00cRX3UYcwtByjU77PnUgRUlQgbJBy8trw==
X-Google-Smtp-Source: APXvYqwEoyQ/+gdbpiq96mf1vlv5hUoY2bhtp6ecuZwu3ufRDNiX4lPMqoN7zAZpCfyk7yZAb5CAmenmXz4Vrtgwk5I=
X-Received: by 2002:aca:d4cf:: with SMTP id l198mr457112oig.137.1557133441163; 
 Mon, 06 May 2019 02:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-12-brendanhiggins@google.com>
 <8c37fd20-859c-9c34-4465-8adfcfdaab09@kernel.org>
In-Reply-To: <8c37fd20-859c-9c34-4465-8adfcfdaab09@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 6 May 2019 02:03:49 -0700
Message-ID: <CAFd5g44q3qyahykujDzOoO01DwGMUm+Kce-tOAzSW90U4mQM7w@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] kunit: test: add test managed resource tests
To: shuah <shuah@kernel.org>
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, Avinash Kondareddy <akndr41@gmail.com>,
 linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
 Julia Lawall <julia.lawall@lip6.fr>, kunit-dev@googlegroups.com,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 3, 2019 at 7:34 AM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:
> > From: Avinash Kondareddy <akndr41@gmail.com>
> >
> > Tests how tests interact with test managed resources in their lifetime.
> >
> > Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> I think this change log could use more details. It is vague on what it
> does.

Agreed. Will fix in next revision.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
