Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8AB21E7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 16:26:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6EF29202EA3E4;
	Fri, 13 Sep 2019 07:26:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=robherring2@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDC29202E842A
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 07:26:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 201so28289991qkd.13
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=azm0iCcEcLT4hP2ezLX9IH/CNTQYVbzbUpSdpFDhS6M=;
 b=Muma7wU7xrn/3eoODqlVRvCuiNodQ0jM/YGuZk17KRlQ+sXHjloLKgfJuARAKNbttw
 ZXWX5nRBYXbMxq6E6UZ7fr7qQd7PA/We79kui5sa00OB1/hT0wkY1lHtAiyJAnq7wN58
 PpC3YvxEID2w1Zc5e7igg13PT9Pslth2O5xmJc4pOdjYr7j/Ux5rLWkxX6CJnc2nxOkj
 uZMZX3jxegkn/5eyV1O2o2Y4AgCto/eztbIswtSKZY6UkZHPbRAJ5Y9LsNt+lBAOhWxd
 xOuuCttfM+CTc5sZpQXgU6mqEbpc4cryUInczp8jAPHv37yiwotDtlI2NtYpu8/HC431
 kjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=azm0iCcEcLT4hP2ezLX9IH/CNTQYVbzbUpSdpFDhS6M=;
 b=YqKWq2IVK1WYVqN8hJrL8OtgRfuXHcNUifieH0UWVHbncFi71WS1JueiDLcVYdqHnz
 TXrhIo+Z85rcZsLJPW36zRB1Ytp3iKWYPu0WtGwq3W5T/QM4T0M7Gi4w3AadAycxPomC
 aWCPnIKWjnyQ65tronThggXLqPlNRDQZiwWS4gYPOkMGQABvnBYjSqVmUHQN6IztLeUg
 o+I+kNaOxeo85NrO46ZGRkgasvwOIdtp8I7tyWFRG22N6pXvz0IT4bqoi7+TJcRJWFGB
 DFlcxWeYSB4UQmwAFim1i4XkRPArEWwFvde7/ugDYmwQUtzWAA2NKTWyyeN2FnAbOoax
 XXmw==
X-Gm-Message-State: APjAAAXNxMQQ9U0bnA3IBcZSZn6VpO+yFKFkwluPSbcTGMC0CGbAqfJb
 W8UM7o+nofTJ6f05c7MHxYN5Xcn1UVZDSGfdiA==
X-Google-Smtp-Source: APXvYqwvIEmEHGdQDy+6TCnCkxmg7LX7EPhqfEAWQyNuhuySpaCg+l4qKRkviip5T5jA3ejq1Vb8Wt7RAKKyifcMyoQ=
X-Received: by 2002:a37:8905:: with SMTP id l5mr47165423qkd.152.1568384789630; 
 Fri, 13 Sep 2019 07:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
 <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
In-Reply-To: <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 13 Sep 2019 15:26:18 +0100
Message-ID: <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 13, 2019 at 3:12 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-09-12 at 13:01 -0700, Bart Van Assche wrote:
>
> > Another argument in favor of W=1 is that the formatting of kernel-doc
> > headers is checked only if W=1 is passed to make.
>
> Actually, but for the fact there are far too many
> to generally enable that warning right now,
> (an x86-64 defconfig has more than 1000)
> that sounds pretty reasonable to me.

It's in the 1000s on arm because W=1 turns on more checks in building
.dts files. There are lots of duplicates as most of the dts content is
as an include file (e.g. board dts includes soc dts).

We could shift the dts checks to W=2 (and what's enabled by W=2 now to
3) I guess.

Why not just promote what doesn't give false or still noisy warnings
out of W=1 to be the default?

Rob
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
