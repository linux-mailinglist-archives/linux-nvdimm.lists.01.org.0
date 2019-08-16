Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F6909ED
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 23:02:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B6CD202E8425;
	Fri, 16 Aug 2019 14:04:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDBFD202BB9B5
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 14:04:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 16so5784276oiq.6
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pzf5ttKVjeyOHGj3IBlJBDsgNbGhDBmBkaYw60KhRKk=;
 b=Ih6cRijzi1WXJSNLOQ5fjrTQfNVdHvPC1zCClUbe4A4GZ+SH2HV5VUDYPxH71hNvAO
 K+zxhM53FgnfZQsPHkv/hVom1N5R9l9Uznj9QLmSdX+oorsI1L/7GwAeixUslqiFcIoK
 sJsBKcxtUggJLyu6CAueRaFQfnw9OH7uYOm4p7932gibeD+HjohvFy7ChhjOTxz4YO46
 IRGGKBFDE5FDfVaehQSFxh5L5NdYA5ht6gn83yeVqIbO3hTMpFm/59QHkNxGZnu3Qmmi
 I4drtOLT3KLfoKwnbIevMG0m926zemLHgV1/posP1CqiaCxqPJQdQifeZFe3Fje4RoZm
 786w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pzf5ttKVjeyOHGj3IBlJBDsgNbGhDBmBkaYw60KhRKk=;
 b=rlbQbxiACYjPcpEVbj/OtJ3V7cfweyKCsW/43+ryx6bUtS863aRHZxJqqVB0MmytB6
 Nyh9zs9sf9Kyn3KLsBXXNjBi2+XWtTV8wA6zGZk/a+ZrFSQuzmYl/MFtRXjacaTcs05p
 V+MhRHX2V6POGLJtXAi5tDcb3BTdlLYN+UQBq8joUkXq2s2ZZImLUN0kcxOpD2MncDWi
 4FNpO+v8qo9F9krEyWj/4mWyc3kwTJq5oJzDm4p+mb/tmH6OJU4FDmZL4MlSiWdCe0CP
 coHpD+Ycbxr7Sd4ba2tg6mHN5SozJ/8V+SHTw6J06hatA1hnpEqbE+9vWqhBtEiIu/x3
 CA4w==
X-Gm-Message-State: APjAAAUWxsS2VSJ61YV0DsR8T19u63aStMMDiiFdT6cY4vwhz9tul5Ih
 LRax/Lz1yVEShLBX7BS6IisL2jChDwbqJ66PuZy3rA==
X-Google-Smtp-Source: APXvYqytMWXAd1gIG3+fmsLmzgobobDXChkzQo57KKls/WBzWZd7ckKQzPYvdyHBOfrSC/IuJzJ5dxaS27c/FqT46qA=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr5715248oif.70.1565989351296;
 Fri, 16 Aug 2019 14:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156583202386.2815870.16611751329252858110.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49zhk8bzuh.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49zhk8bzuh.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Aug 2019 14:02:19 -0700
Message-ID: <CAPcyv4iPBO9atdr_LdHNt=tCgjh-j_HyKXaCdUkWxb_J7OCcxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs
 security operations
To: Jeff Moyer <jmoyer@redhat.com>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 16, 2019 at 1:49 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The blanket blocking of all security operations while the DIMM is in
> > active use in a region is too restrictive. The only security operations
> > that need to be aware of the ->busy state are those that mutate the
> > state of data, i.e. erase and overwrite.
> >
> > Refactor the ->busy checks to be applied at the entry common entry point
> > in __security_store() rather than each of the helper routines.
>
> I'm not sure this buys you much.  Did you test this on actual hardware
> to make sure your assumptions are correct?  I guess the worst case is we
> get an "invalid security state" error back from the firmware....
>
> Still, what's the motivation for this?

The motivation was when I went to test setting the frozen state and
found that it complained about the DIMM being active. There's nothing
wrong with freezing security while the DIMM is mapped. ...but then I
somehow managed to write this generalized commit message that left out
the explicit failure I was worried about. Yes, moved too fast, but the
motivation is "allow freeze while active" and centralize the ->busy
check so it's just one function to review that common constraint.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
