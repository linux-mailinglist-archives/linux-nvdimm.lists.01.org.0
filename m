Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7F32675B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 20:20:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5336100EAB78;
	Fri, 26 Feb 2021 11:20:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E14C100EAB70
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 11:20:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so3153545edx.1
        for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhM0tVQWF8kzr3/IcadJQ+8qdq1XtQmOXaLGMkTtePw=;
        b=FlPQwrTAoaNGYMFZQvI9fBh2dvf4F9S0O3OxF/Erg+JoJ8RTKBcX1uAoKkxTcKzxem
         uOEtSEtzBkJWDAXKPNfAbGVQW+Q1USi66//Wt/85rTYnED6qm2LWs8jlcmvOu3Y4QAFd
         NAmL9nrHdfdDXARigxJtNu0UAp/R2kRG1cbv0UAGyoJAZOQFPxfX8yXUgNbFfStCJuZL
         YdGfVIArV8IOAiRdjk29NIxn5oQCayBFNF8S7z0E9DrzBzI5nTXrnHWHkx5o17/OWtHx
         Xbe2Pzzf9XQ/xWg5I2PYrsd5QPl0RUN5d0fF5ND8WWJNB/SMA+xOVL0vYpJL1XHx2/dV
         cQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhM0tVQWF8kzr3/IcadJQ+8qdq1XtQmOXaLGMkTtePw=;
        b=gpesFkeSJf6sM3urSWEniYEwFUrzo92oSAaymoevWX47zYEAoHgBAPDxhjWiijL0rM
         OEHgf8zbGnaQKwIv0p7RpQCTLenIlGWYp5Cgg1iK32cz8c+SF06YSRbDNQm4urMJfplR
         YSjRQZpnp8UETC/Xhs0M8/RBh1FHfJmnz1sdKuDOW0UMyAZpf1iR8R1OmtqZbWiAlKkl
         GjSFlgMynfR7Z8oCuHDa75qcr2wn24SAcAcOGK6ErHxIFnQpWkZasS04XJ4ZGGIKXxbR
         FGo7JIeCsUGwmNoQjPIZU2VUMKl1Cwxd+sPSv06p8RDkKLAyJQbA9ebCxdH8waDzBBd/
         nsgg==
X-Gm-Message-State: AOAM530rOEGCt7nWK6Sp/zUpmTR4NDSpUIB8HKoDcVjR5/huTcuj83m3
	fd4yvSC/6OlThcdPRT76AYhhCQmQ6gaE1fZUdFQNhJOIxLxTnw==
X-Google-Smtp-Source: ABdhPJzTF95rWcMrenF566dYnxcuI0CzJPIK7LK9Pxu01B72JTzOdyX8nKKAEkePfvYUdBEEQFKf0U/ux4FU2DpKERU=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr4997867edc.97.1614367250184;
 Fri, 26 Feb 2021 11:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20210224234814.1021-1-erwin.tsaur@intel.com>
In-Reply-To: <20210224234814.1021-1-erwin.tsaur@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Feb 2021 11:20:39 -0800
Message-ID: <CAPcyv4gNddAb0+_q4srSnchGPEda7nD2=0rJR=20_bHUxGeuwg@mail.gmail.com>
Subject: Re: [ndctl PATCH] Expose ndctl_bus_nfit_translate_spa as a public function.
To: "Tsaur, Erwin" <erwin.tsaur@intel.com>
Message-ID-Hash: BTZHYP2V4Z74BCXEMHG7SPBBJ5YFWNBQ
X-Message-ID-Hash: BTZHYP2V4Z74BCXEMHG7SPBBJ5YFWNBQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BTZHYP2V4Z74BCXEMHG7SPBBJ5YFWNBQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 24, 2021 at 3:48 PM Tsaur, Erwin <erwin.tsaur@intel.com> wrote:
>
> The motivation is to allow access to ACPI defined NVDIMM Root Device _DSM Function Index 5(Translate SPA).  The rest of the _DSM functions, which are mostly ARS related, are already public.

For future reference you'll want to fix your editor to make sure it
wraps at 72 columns for commit messages. If you're a vim user, I have
the following in my .vimrc

set tw=72

...and then you can use the 'gq' command to fixup line wrapping after the fact.

Otherwise, looks good to me. I was worried that you needed to double
check that the bus argument actually is an nfit bus, but
bus_has_translate_spa() already takes care of that, so I think we're
good to go. Longer term if other buses grow the ability to return the
DPA we can add a proper generic wrapper for that, to date I have not
seen much support for RAS brewing in other buses.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
