Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9975D3B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 04:55:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A9FD212E13CF;
	Thu, 25 Jul 2019 19:58:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6888D212D277B
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 19:58:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j19so15430158otq.2
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 19:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NBRry883zAMpt74Z3Zhim80Gbk/StHHHZsV8U/6Ours=;
 b=ItJ3FLKSwG3k5AlxddpfZJgIXHYSP9E3lXVyRJGrrvIMe4CPUZP/UyGQYUnhp/JlAG
 VmrDH8cbWGep3yi00YAH3pyychnUuPWFlWfsQfMmXxiJhu3jRlfI4pZDom8QFNh08yX9
 nuWPmkbdxyeS+njtLsb2Fb5iznHq65XtgmHtJKcQFC3EiuPDb8ojfpXUbPsoxAXU+G9x
 27cuCESCWfUoaiCoNAcpZ//HLEpsEg/z1ATZPwOkydHWfWyrFWg/TRVQHCZFl2PT3HiZ
 z8AK2yXSnRdoUE3psQe3qhpj2trRCPpO9aZiDhsTZJ30hQQRHpbNwfAz8sZmsHe+9W8h
 hrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NBRry883zAMpt74Z3Zhim80Gbk/StHHHZsV8U/6Ours=;
 b=GXi7q/1gtMA7IOKaGPecgQPYC+5MoJqzmG89qMbNKiiB46UkV1EsCqM6VBTE4QTXba
 R9TjSm0GwD/Vo2XlGMJ0uH0gfqNO8ShLyoVGlcgQGIftMsDXq9icEtnMPF4YNxTMsQ8i
 rvxTeEF13Y5BZ3S1fhPogNasNc3zTpOajwHJW3ugHGHhwVte6Qy0kHqgLWzuW65if5n0
 yU73cuajdxd3GoZFBOZEd0N5dGIGnquWyIixZpMNnGGVgXOjpl/+neT6oPj83qNTzt4k
 tWLVK96ciVV8Nc/sAOYRXigHJi4F+3UfW2aQ+yzrNXQSbwY3FxQuubVNpEpu/YiJ0oql
 9g3A==
X-Gm-Message-State: APjAAAX+evW0D1+S6fQFcHRHT7pXtDNbX72rcze5jkTVKzeFmQaq6lWq
 M2uhhkyMBbElhGxUqTpDXjKO70Z6m3mMf+bAIUQcDQ==
X-Google-Smtp-Source: APXvYqxux6JellmitqNgMPhit3xR+dlMZ5VUA7T8Q1iVWp723a4xxUAH/TS0O1EyOshFItZyWFWCHJynbXjZ364cre8=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr41642686oto.207.1564109733932; 
 Thu, 25 Jul 2019 19:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-12-vishal.l.verma@intel.com>
In-Reply-To: <20190724215741.18556-12-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 Jul 2019 19:55:23 -0700
Message-ID: <CAPcyv4g82poaqSNZh+Q_QpdWVqjmz3C=BM74Guoe_Wj7bv6kwQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v7 11/13] contrib/ndctl: fix region-id completions
 for daxctl
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 24, 2019 at 2:58 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> The completion helpers for daxctl assumed the region arguments for
> specifying daxctl regions were the same as ndctl regions, i.e.
> "regionX". This is not true - daxctl region arguments are a simple
> numeric 'id'.

Oh, that's an unfortunate difference, but too late to change now I
think, good find.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
