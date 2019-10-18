Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B600BDD090
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:47:10 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4374B10FCB917;
	Fri, 18 Oct 2019 13:49:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8396410FCB917
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:49:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 21so6053056otj.11
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADTLHgh83KN3OGkZ8kui7Neb3bi9dKq7zMcjNoTsOWo=;
        b=oagdp4ZyV/t5fLXHjw9vZW7LaeE2OHDljIFtEU4M1xIaeo+t33a1ERHqn7m/GeJGLJ
         T/BUBvrGiyOyD5cAh5uxX2aye9mSy9AKcswC9qmAsWALhZKa4fPAEYop5gib0KVOOscY
         i/5mQK6vd4dX4bOOQGdW9+utsC3VV35hCCYuvNfrQ+2TNfNIlqEy8rEUz37OEvt7OhQb
         albmO3ZTAnsFrI9y+7lQmRlmpgnQrgumXfU4ANSPAkqVf+m+7+O5XD96Abssm14vYgNF
         7IIJnhQQ1H2GRLplqjCbp7hK+sttjXerQOlJJQnEH3708IHNr8b85p0IwNntMzGMXt24
         MxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADTLHgh83KN3OGkZ8kui7Neb3bi9dKq7zMcjNoTsOWo=;
        b=tr1qBVZaRPIz8SMxZENjG4ZnvXnQ734OZ+X5gM6gvzXSVUjgH4oWpJTpy2bB6luvEf
         pQLhklos/080U0Bi1FZWc/LSzBjLrQfmHbvaa5WHsyI9RK4rBc1JBSMeIrAaUKo71hVZ
         ++FCX5Fj25Hd+s9tXNb1LSRUmQcJG6cB8eqT35DototI3lqd5HM1zT03J1IktlgyXgbD
         M+Tp6YvGWyWP2jpaHWdmN1JX0cISEyZP3XCwqDDmTuAEAnkX8HLqmJ0PL7pkMKeyET3W
         vP3a5BW3TOizrOsr98ytr8OO96kHcMGP6d+8SIeYbmazXCfPrLQm5rb/+unvwnQjkRQO
         RO2w==
X-Gm-Message-State: APjAAAVL4XV58iSFBIl1+mgo0RUrXjtCzVFxoFrRVGEcZF3FTvA2zCkW
	zlAYqiDOEP1LS8S/tpfQRc5VtC07d01MJk13qcvXGQ==
X-Google-Smtp-Source: APXvYqwUjEI5RdN+en0alCmMtBo4YLwOk98w5gXBntpVThb5DCvhNRvHhQrrMO1lBUIeicFMUgk4rNZJjtQyTrASQQo=
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr9036935otf.126.1571431626359;
 Fri, 18 Oct 2019 13:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-9-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-9-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 13:46:54 -0700
Message-ID: <CAPcyv4hHT1fjPirPE8Ex5NZ8_4SjoTj-GNaXP+0+14jNBCHTig@mail.gmail.com>
Subject: Re: [ndctl PATCH 08/10] Documentation: clarify memory movablity for reconfigure-device
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: X5EON3BOMN5PMOHLAIESZFRJYODEKFYE
X-Message-ID-Hash: X5EON3BOMN5PMOHLAIESZFRJYODEKFYE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X5EON3BOMN5PMOHLAIESZFRJYODEKFYE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Move the note about potential races in memory onlining into the
> 'Description' section to make it more prominent. Reword the note to talk
> about the sources of such races, and talk about the new 'race detection'
> semantics in daxctl.
>
> Link: https://github.com/pmem/ndctl/issues/110
> Reported-by: Ben Olson <ben.olson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  .../daxctl/daxctl-reconfigure-device.txt      | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
> index 196d692..4663529 100644
> --- a/Documentation/daxctl/daxctl-reconfigure-device.txt
> +++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
> @@ -97,6 +97,20 @@ error reconfiguring devices: Operation not supported
>  reconfigured 0 devices
>  ----
>
> +'daxctl-reconfigure-device' nominally expects that it will online new memory
> +blocks as 'movable', so that kernel data doesn't make it into this memory.
> +However, there are other potential agents that may be configured to
> +automatically online new hot-plugged memory as it appears. Most notably,
> +these are the '/sys/devices/system/memory/auto_online_blocks' configuration,
> +or system udev rules. If such an agent races to online memory sections, daxctl
> +checks if the blocks were onlined as 'movable' memory. If this was not the
> +case, and the memory blocks are found to be in a different zone, then a
> +warning is displayed. If it is desired that a different agent control the
> +onlining of memory blocks, and the associated memory zone, then it is
> +recommended to use the --no-online option described below. This will abridge
> +the device reconfiguration operation to just hotplugging the memory, and
> +refrain from then onlining it.

Oh here's that full description that calls out udev.

I think just "See daxctl reconfigure-device --help" is sufficient for
those warnings in the previous patch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
