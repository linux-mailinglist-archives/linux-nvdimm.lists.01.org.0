Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E394EC8E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 17:52:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC8902129F113;
	Fri, 21 Jun 2019 08:52:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 10FDF2128D681
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 08:52:54 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s20so6782869otp.4
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hwqOdM82Wo1LbISqbfrlEuypIslSLM17UE637RRvbw8=;
 b=SUa9qJqmUw8/97wTcjAtEu0c8O8rYc113LWn47+pi0EwFgnYlKQ1z0ZxoOkAF8GaBz
 CI8EGatu38vevaNJy4aAulu0TeQY2XBCwSsDQVd3yrlPq5EdRAZdIlfwtZ7SQPBjfZdv
 xlWhsraEMFPoOvMO+3dvX8CYj/co9++szi1UeVRPgS/N3fcNtIXlOA3n/UERMozZ4YTj
 udP8L6Ja0sJA8gCqPq1zXfRFRNOq4UI7lPB2mkcOk3+5gfqEYobvALSufLiEsVtzuu/l
 xzfTZf4sKDfpLLodPGKSrD3ZW9rudc45eBU6Une4RyhwaykYLTJMRNirDBr9guxl4wNN
 pfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hwqOdM82Wo1LbISqbfrlEuypIslSLM17UE637RRvbw8=;
 b=oSqJLo0B9793PeZAzMLeAqO7fs9HzzpYJLUk+y9IK+P4pKcoz1Kxl/TAwCUfBsbwLn
 OXQL5PskLroU81LzXfgXoV8GxgcbxdRdZlsGfkpccaHljoLPivs2OhDolS6geRPtF8/j
 IrA5vIN8tXM+KuwUU/UzL8/MxlQeFYMHYSm6DKJeb8kcJDbW3pFy8KhoKlOfaw8rXFMg
 2KOJKxkJsFpRW7stX2Qj44y5plXVStOEEsv5dP1NtbqmPM4K1c6Ed+g17TmU1CevF1ER
 A7GWjO0iU3kZbpWrfFlYh0e0smXhu8BxqamaSGsLr386QgUu2QoOZtArfvy4WRhmRWYA
 Q4NA==
X-Gm-Message-State: APjAAAU1o9U+MqBJWU3lVshuHxiZ6COn/mSbwuiknizGXHj3NzVScqao
 JrJDPq9n5wZTdWHsPHsUDf0tU3QncPYxz5o7jxh0pw==
X-Google-Smtp-Source: APXvYqzz4LLcZrrOrjeYJq3IZMtx3xFuKyLY+v6Wc96BzzmVMslfTxTEKkzMDFWbxHG/xmFknenxwPz1P2pt3ztvzrU=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr4310909otn.247.1561132373730; 
 Fri, 21 Jun 2019 08:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190621114518.56321-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190621114518.56321-1-andriy.shevchenko@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Jun 2019 08:52:42 -0700
Message-ID: <CAPcyv4jtioTHQrSrZhopnKzPe81OYzBxpCeY1yCRLoxS8ULVzA@mail.gmail.com>
Subject: Re: [PATCH v1] libnvdimm, namespace: Drop uuid_t implementation detail
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 21, 2019 at 4:45 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no need for caller to know how uuid_t type is constructed. Thus,
> whenever we use it the implementation details are not needed. Drop it for good.

Looks good, tests ok, applied.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
