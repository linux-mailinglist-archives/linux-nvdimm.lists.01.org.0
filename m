Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F1B0A2D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 10:24:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8558202E2913;
	Thu, 12 Sep 2019 01:24:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 15A75202C80B7
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:24:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a4so22710713ljk.8
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ECkS2puFAK1gVjPinpMaI687BSxI+r7g336/1esz1k0=;
 b=bobU2/X+jXrG7Z7VhdAPWfrQEBrRDHgblPscgg39+wUJnCf7d4fx3qf6vcFFVvxSkN
 3U4gbkvDhjbCnuW8meMQgC2Ft3e3FFwa0KHF1D5u7qW7MBU1GnNfd/QMkK8wWUaaRqCB
 3JpC+A70eitPZT6pl0sNnHh2A+r/Bjvb6UnMxMWGl1ObfMLIR+F5cnwsHKrEwhjq8yyf
 MAFpuPAHwSYnNDLUlhili68ZfGdf+ruL/K0+YDRvDT04U78lShW4wiNWlvwbwU67SIo/
 T3D0trHu4hTkAJJSD3d30zL/Ox1rPT250C9erYGII76G3/3XIUEY41WiGKx5RXmDT1UJ
 x+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ECkS2puFAK1gVjPinpMaI687BSxI+r7g336/1esz1k0=;
 b=lzfLRXtA7p2UILh3liczACFYek23JK0qqAeunjRO4C1qc5RI/KQtbZ+B37CAp7P2g4
 01/tiqkyFPz31LoZWiy4X9xLkTQ2E7la3ieuD3GcHCDkzaCP6vgpuf05H2+MXvhb2Bj6
 6PXL0QpD84/k9xOf502gWOACAE1iLjgOM6Par6uSy+IPEA4VcgH4Kuy6HrU0oHBQkYCi
 zPuNBZ5VOh9nh4zqC/tWOUkd007egFiKnol7ODyOi7+cER4NgtJs7+uHOwMGsEzdZ/7u
 0tcEtk3ZlepzC0CpwLL7pT5lLFXe/duK60FZuc9CZ+xLUJerLHxZOTG/HvozDqhTQWNN
 cxkA==
X-Gm-Message-State: APjAAAVyYHyPXhn+vcXvkmSF+hIU3zgJWc/B+vjAteiKp6CFgFu73wV+
 xhYMo+K9QqqlzZRZ9rIDxSyUMRV549sD91iQ91o=
X-Google-Smtp-Source: APXvYqwJdAIg0MN468eMceiqvbqhEFZIaSKfHpA6hbEW7p8IU8l3e2/DQsQGc8lPdxLHrAXG/fVObo9RcVpmFUoxXg8=
X-Received: by 2002:a2e:9555:: with SMTP id t21mr9396134ljh.93.1568276653052; 
 Thu, 12 Sep 2019 01:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
In-Reply-To: <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Sep 2019 10:24:01 +0200
Message-ID: <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: Jens Axboe <axboe@kernel.dk>,
 ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Now I come to find that CodingStyle has settled on clang-format (in
> the last 15 months) as the new standard which is a much better answer
> to me than a manually specified style open to interpretation. I'll
> take a look at getting libnvdimm converted over.

Note that clang-format cannot do everything as we want within the
kernel just yet, but it is a close enough approximation -- it is near
the point where we could simply agree to use it and stop worrying
about styling issues. However, that would mean everyone needs to have
a recent clang-format available, which I think is the biggest obstacle
at the moment.

Cheers,
Miguel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
