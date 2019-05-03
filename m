Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED01273D
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 07:48:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B45C21244A1D;
	Thu,  2 May 2019 22:48:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4A8FA21244A12
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 22:48:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id r20so4312692otg.4
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 22:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yJk8vxgxnyREeORp3ZGYiUe4W63+mvTYx011g+D2w9I=;
 b=gVy2A/3xGfxoPlL5Ko9/iS3jo2EDVupQVAr70qs6RZrFHNgUtzEok56tjyUqT06FB0
 N61EUVCJQSGnIGYHynH3drr29YDViWxqPU9Sza34pLTsoxVh0uUM8E5CV1L0C/mIM9w0
 WGa5tKq18lnS81IMo5BcR1Ykh3Nl7b9ExnnVx27s6jE5lyDFV5nm2p2xr1/VPFBW2Ah2
 kgZSCZQGbf96we5F6/cwHf89KEU3jBrsGd1WH/gd1lUYccvZTH42q4V6uaQ3GXtHhroy
 5qgEL+EjcYwXRo906ivSwsvihl3a7m9bzISXOlTNYJMfYhl7JWVTEbNxfJuRwSUQRKBU
 kRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJk8vxgxnyREeORp3ZGYiUe4W63+mvTYx011g+D2w9I=;
 b=mAOieiktOV/wlxVA9wfmPWtQ/sCBKCcTa80fhc+vjZAb+A1MLIaDyAmxa8KSxUYtGv
 mM6eCbT5IXWrYLz3+2+yvtXxY/RAgupafJFviVg99jToCw90xB4+ZfGbFe6y4GAvnfAg
 +QZVtAiTjtjQYCCW07Ua+t18tAh0r6c9Bc/M3K4fAgStodIDxGbgnGt9Cr0QbUDznKNP
 bxfVa8QKPHXUgmJXiJHbx5ogxM1zd2BusKPSTgvpbKQjpISPX7MjRkLyBFfWm2wL9Io9
 dpRldJEiGz2ZF9LPr342sY6bn/GiahWEjOcNj3T5cPoIJ3QizgjgRIs6xqBLGS4sEYGf
 GE/w==
X-Gm-Message-State: APjAAAXV2GULjYlEyGb1cJ2+G14uenlNZbv8p47xPnTxHYV2gkStedAI
 nWujFh1pSrKGeb30h5JxOs+UIIQMgOuc71mkt7dj3Q==
X-Google-Smtp-Source: APXvYqwsEAlSz/eNFlgajgo4Kt8DHISJN+MfNVQqCm9syohvOOWU5/fOAXzlAO0OoVTlNR0j/l6/cH2CfoUTavBQdJA=
X-Received: by 2002:a9d:3621:: with SMTP id w30mr5187084otb.98.1556862507760; 
 Thu, 02 May 2019 22:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-5-brendanhiggins@google.com>
 <ead23600-eecd-cf74-bdd1-94a6964e29b2@kernel.org>
In-Reply-To: <ead23600-eecd-cf74-bdd1-94a6964e29b2@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 22:48:16 -0700
Message-ID: <CAFd5g463PQGn3618Vo2Spu81zzL40jM6Skr1gSWtJqMx7Faj5A@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] kunit: test: add kunit_stream a std::stream like
 logger
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
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 6:50 PM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:

< snip >

> > diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> > new file mode 100644
> > index 0000000000000..93c14eec03844
> > --- /dev/null
> > +++ b/kunit/kunit-stream.c
> > @@ -0,0 +1,149 @@

< snip >

> > +static int kunit_stream_init(struct kunit_resource *res, void *context)
> > +{
> > +     struct kunit *test = context;
> > +     struct kunit_stream *stream;
> > +
> > +     stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +     if (!stream)
> > +             return -ENOMEM;
> > +     res->allocation = stream;
> > +     stream->test = test;
> > +     spin_lock_init(&stream->lock);
> > +     stream->internal_stream = new_string_stream();
> > +
> > +     if (!stream->internal_stream)
> > +             return -ENOMEM;
>
> What happens to stream? Don't you want to free that?

Good catch. Will fix in next revision.

< snip >

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
