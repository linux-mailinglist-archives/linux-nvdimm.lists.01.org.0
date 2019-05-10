Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E431A391
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 21:59:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A56C2126CF93;
	Fri, 10 May 2019 12:58:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B8B2521268F9C
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:58:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g8so6655019otl.8
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DNwUSSFtIDzybf1LRY2+XuCIYFmFlcLpqkrh111i0kU=;
 b=GJ/NArJvWOMdSc43N34LltE3g/bn9Rn4QIdLngl626JdkLtkweABfKuH5ySks5Zl6J
 eobiDhd+fEn9Wux8FZqlx1gr5mjUoV0J9Bs7yGKEDPfSPfWWVl5FEyL54fOBiNYFd9dL
 Q2vV5/WG/heUyehOzGD0NuRiy62r1m/oo4QrRgbTyZyIWZ3brRIk/HOwM34sSAiufDXN
 N2sMi/YweesKODyp+aKg/IwQHsGPxN7C8NJouF5V6eCPbAy30aUxQQhDyw7BOV6yV9GH
 KZIERAmZOfYy2T57ChQf35W2WMPMDu6H1wdYY0Lph3QipwAASU/lqjrh/jtEYyNBJMBE
 9nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DNwUSSFtIDzybf1LRY2+XuCIYFmFlcLpqkrh111i0kU=;
 b=joGL6SoeE2N+OqdY6ISpzDtVRho0/p8RAkJiiu2QkIfpq8a1DOXGPd4Z/Uj1qotav/
 iGNESgfQnN9xIXjIb6p863dJxKaEfykUWdg3h6bb3u+HAE9Zkayioe0W99GmVC+ZRK7g
 3Hf1oogQEzMlpAAiZtv7n2ucbfksHmUTvgB3cglAqok9BqH50tZcICReAN8/on8iRF67
 hepjXv9dpUHIhggZDXG+UO2SnY95HNHr8rXRIncNj0Z+c0xkQZ9ENWhzXm9tO8nNZJig
 1xr1j9dYDcsfCkXirmsNmqn3zhcLpWZMB11opXlX3fzENZBdhKwYhysFeTj45gRd2Qlj
 5KDQ==
X-Gm-Message-State: APjAAAXj/ELcRwJM2B4FRREdEu0opF7VDmQBsciT/SvD2wLGXvMjC3/p
 OSAJzmlEe4UbHw7p8qhR3cmvgaz7vTAfWH9CVNXaZQ==
X-Google-Smtp-Source: APXvYqyrHJVzV58tHanSbfQNdCzWPfye+Ao1QDyL2e16iMp5EMlw7VfFqf+qqtSg3mcIMotWBvo68BhQGb2nsLRqlXI=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr7865082ota.353.1557518336186; 
 Fri, 10 May 2019 12:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190510190839.29637-1-vishal.l.verma@intel.com>
In-Reply-To: <20190510190839.29637-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 12:58:45 -0700
Message-ID: <CAPcyv4h+hRYTAefvK78PEe0+1UQAmmvR=feDderNc7nB35nGzg@mail.gmail.com>
Subject: Re: [ndctl PATCH 0/4] static analysis fixes
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 12:08 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> This series just contains a handful of static analysis fixes in
> preparation for the v65 release.
>
> Vishal Verma (4):
>   ndctl/namespace.c: fix resource leak
>   ndctl/namespace.c: fix an unchecked return value
>   libndctl: Fix an unhandled return in ndctl_bus_poll_scrub_completion()
>   ndctl/namespace.c: Fix a potential integer overflow

These all look good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
