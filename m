Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE4225F9
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 May 2019 06:46:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3E7A621962301;
	Sat, 18 May 2019 21:46:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B975A21219AFE
 for <linux-nvdimm@lists.01.org>; Sat, 18 May 2019 21:46:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v2so7810211oie.6
 for <linux-nvdimm@lists.01.org>; Sat, 18 May 2019 21:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gj9Btx/jtZWCRzYf1e68GHq9hnNL+Ogbx99PZIgoB74=;
 b=he4EegSmAY2zYl4r6S9HGzKLVkT8LcOlIiHygVYp7zaifYHKTOnLMI3o86dBf9LnbA
 hNpn27eEyN+qjhPr4EWsh41NZcuWKx0QV/Lm3hbJvmg4w/a4SM3A6yP64JFNN7ArzrWN
 LmBZN1YUxjOCOk3FCPXXbnD3ysP2yAjgaksZCoteXGH8VH61lmvwvYl8cSGa8tPvrlXr
 xPan3agZZxXKJmJ5Js9Nz6/gSEQCRSxaaZuflHI0xI3I3tFi+kBW1X+kpQ85pzisWSZk
 tKdYRCV0JX/Fq5SKy2oGR4hlkUeMEXHgWn14Ltr+Tbi08WwF6ZAeblRmiNNtO42MgwiT
 kfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gj9Btx/jtZWCRzYf1e68GHq9hnNL+Ogbx99PZIgoB74=;
 b=BhZzllHjRenfGB/5+Io8BJw9gbtUd3PsfovpeOXcGWylyNp4JYk4yaTFXkOnxokeQJ
 Hvex1vRm2fiLs0PjR6HwG02GsU4iAuW4yzTXDbLq4O9r8d5qatnHGW9+Pa2qrSBRK88W
 2JETXKKgnMgsB86uIXZF/RyArwWS56gTVNkryfRiXPy0YICF/Bd4Rzhlj3pSY4c5EIvz
 q9PJf+hMOgbIcERzjWG68dEVaWzPqlhLCK4Ij48RXBMmRmTNlZ+cDy9fvhTAMZ/N9Qna
 h45VotzwLdtSGTgiu02eJPXvn1R930QWZWr5KbHBvSP0ocE3lIh01sQDK7G7jAqXLW72
 njcQ==
X-Gm-Message-State: APjAAAVOV+uu8+G/csLW65VXSOps+I5bLDTz1nK3tDX35u4d7XYxLNLN
 br1mNKfTg4s1nOM8ClZiiLSO/wzIZVc8uIaLMww8IA==
X-Google-Smtp-Source: APXvYqzKuIF7DjE9geOB0iP+nbKCvx7yts/nthzaKm8X4SzrLuLauoovdM83byX6mPO6HfMrjjhanslT2cwm2r59jc8=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr2335808oie.73.1558241173924;
 Sat, 18 May 2019 21:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
 <201905170855.8E2E1AC616@keescook>
 <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
 <201905171225.29F9564BA2@keescook>
In-Reply-To: <201905171225.29F9564BA2@keescook>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 18 May 2019 21:46:03 -0700
Message-ID: <CAPcyv4iSeUPWFeSZW-dmYz9TnWhqVCx1Y1VjtUv+125_ZSQaYg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
To: Kees Cook <keescook@chromium.org>
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
Cc: Jeff Smits <jeff.smits@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 12:25 PM Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 17, 2019 at 10:28:48AM -0700, Dan Williams wrote:
> > It seems dax_iomap_actor() is not a path where we'd be worried about
> > needing hardened user copy checks.
>
> I would agree: I think the proposed patch makes sense. :)

Sounds like an acked-by to me.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
