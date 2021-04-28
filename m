Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A236E0B6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Apr 2021 23:08:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 484BC100EB84F;
	Wed, 28 Apr 2021 14:08:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B66B100EB847
	for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 14:08:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so12337005edn.7
        for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVM+iCdaFxsIfPwq2nMLDZ6TqTYet379ZeoHbJGRbTQ=;
        b=xgecX1li+vZtq3cln0N6XPWA+P7KKlGO+QkJHeToGBYOk+pJGm7UzU6xHUtWnxUoUd
         k4SObdNEzxatSE1/axJ3GHwN9LyypcfNVyIiyyduihy/LYRAlkQ9kK09QkqhmtGDaquq
         ZKT8sZz/ERBbzZ8USiHw1BsnjPcRwSD8s47+G+R1CHXkx+Rnu6EWxm5pZre87qVZZdME
         Lg4qoLDGAKY2bs87DtmBn1Vghi97JwG+cuMHs7QBI4q6aynW9zyBY9rxnZ3NmxOujD5U
         Zr1x1W0WpgejANg2Szdhoe0QlIDP2pmNTJNK9HBrZA+0u0xsEWoPK/FMGt4Mzc0kx1Wm
         FvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVM+iCdaFxsIfPwq2nMLDZ6TqTYet379ZeoHbJGRbTQ=;
        b=M4KCNyG8DVwwIMbZalgyX1mVU9zUDH1uWFyNhEgt4VDbU3ytWHLNL0JqAoti6Gp+3B
         NjXSnFi1nilUMk/hbKyJKIZJy1F+vMv/Mpuj2nK9FnPJaG9W4ON/KzscbAkj/zByHemh
         aMkj2tx9F305xRQYYgl5GGRh1F7fVbwYAP+joEfgQr4HJvwKp99qndLgNkzAMhKXx+OE
         VzIFVs7TTk1waBDniBvdjdUri5RfCymSzBBdjMOXDeil7JYDISjH9TlXpHl+jcZ4XWFn
         qh/846J0dHIJqaFYdtizMW2uLWG/Z8kU66Uo26X4OZL5EU/goTy0Ip7NkV0KiBVYJ/A2
         j//g==
X-Gm-Message-State: AOAM533p6//td92aQjQcmTLBIy7MnvuTgLtBOP2gpqVfkPc+rAL10IPE
	Cz/Q0Db+zx0pYTv/7z7oy8uMHla3CjUEEFxod1qf8g==
X-Google-Smtp-Source: ABdhPJxstAbCjBnNHZqdoBSMGGEklrAQj49GAceBkw0Svq0mJzmb0vA0NIyg451Fm4fflP37wNtdmIBaLeg1Zk8giQc=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr2830019edx.52.1619644110204;
 Wed, 28 Apr 2021 14:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210428190314.1865312-1-vgoyal@redhat.com>
In-Reply-To: <20210428190314.1865312-1-vgoyal@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 28 Apr 2021 14:08:28 -0700
Message-ID: <CAPcyv4jYyYOXyZLv1Pz3Vy1U7B7BzNrp4TO1MzANkYOMA0u_4A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] dax: Fix missed wakeup in put_unlocked_entry()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: APJ4IRX6BGWM7HIRU4TETWN5RZXYP4TX
X-Message-ID-Hash: APJ4IRX6BGWM7HIRU4TETWN5RZXYP4TX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, willy@infradead.org, jack@suse.cz, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/APJ4IRX6BGWM7HIRU4TETWN5RZXYP4TX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 28, 2021 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> This is V6. Only change since V5 is that I changed order of WAKE_NEXT
> and WAKE_ALL in comments too.
>
> Vivek
>
> Vivek Goyal (3):
>   dax: Add an enum for specifying dax wakup mode
>   dax: Add a wakeup mode parameter to put_unlocked_entry()
>   dax: Wake up all waiters after invalidating dax entry

Thanks Vivek, looks good.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
