Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C0DD0AB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:54:23 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE13610FCB923;
	Fri, 18 Oct 2019 13:56:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0FC4A10FCB921
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:56:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m19so6130798otp.1
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuLnk9TLuVHwPdx7gV0JSwDVxrkSk5xzOveB4VptdNw=;
        b=y2WAtntc21ydcDLVCF5OpRsHmZ/vwBDdMFoTXdLxPBeqrPKoG8POWeXJakzfWiECYU
         QDsFIB1wdaQcaoqjnUT6pq9/GohDgugCirJz5VaGvPr/47CMp9zJAS1KwkcxYxot1ftn
         yu2RDnjqbj6CHZoH4CejuxrXkPlOZ1VRR5rn8Fh/xyFaG5mQ34ErUcfDm2zMlBuOxQsF
         rsoNg6xb7INys7S6rnyKC9Nv0Gv9Jv4ZHNqlojMepjT7UF0nGBc+zew+2ZD0GPNeKXd5
         kuU94ZA80xKcx3zxcGr7HwOIJH7L/u8xEd1LTomjV4toYuv0R51Gj62eE3hMfVyNhcJz
         Rkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuLnk9TLuVHwPdx7gV0JSwDVxrkSk5xzOveB4VptdNw=;
        b=tFD9Pdbbf7O4XkQrufsouIqSM9ZMeMIpARi8ZbDORfyLkSM3zOz5LoImC+/tjztwqT
         4Sytzq1FaTpPGUsE36r0CITrS4OPDC7soQopXXVCzfLNyUCGd0O56OeszofMtAenO5W7
         oJfvqoM0r1ZPUCA2TxUWswiWlvsIChVIW35399FZ7qMPiZ7Qh6zGLBLdvrD+X+zHE3q8
         1Ul9LwG+ycbnCM/Z+I2VZN8bJN7uVkV0g63kATcEsg3nZxaGQYFjsBIj9LNZUjmXvV3W
         7WsTZx/EwQk1Xd3TtOoasid5qbwnZBYqj4+iiW/UzQ20kq4ffbuDhEs4rr8zhorQgKQ0
         eGRQ==
X-Gm-Message-State: APjAAAXEVupHgLxqWw+AKZJvTTgcFfXdMCgF0t/c9PF3gFA6rpo2DfQ4
	ACPBfFP0y0MX+SOShh8F4Yb/eE1rWTiDU8HNgk2g9g==
X-Google-Smtp-Source: APXvYqwdRU+YNjlpX1/QNAr5hJK2QqZ1ghmlQ4VlIx1peblM67EsZBkElgIWMsYt9ld9L90OKheN5uJcFNh2ghWotIY=
X-Received: by 2002:a9d:7843:: with SMTP id c3mr8613884otm.71.1571432058047;
 Fri, 18 Oct 2019 13:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-10-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-10-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 13:54:07 -0700
Message-ID: <CAPcyv4j3dTA9DYLtQ_O0zaeujvuWuc_+zPJeK2dvue6WsT2H=g@mail.gmail.com>
Subject: Re: [ndctl PATCH 09/10] libdaxctl: add an API to online memory in a
 non-movable state
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: OROM33E462IPSFUDJJXEHQRDAXQC5K5Z
X-Message-ID-Hash: OROM33E462IPSFUDJJXEHQRDAXQC5K5Z
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OROM33E462IPSFUDJJXEHQRDAXQC5K5Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Some users may want additional control over the state in which memory
> gets onlined - specifically, controlling the 'movable' aspect of the
> resulting memory blocks.
>
> Until now, libdaxctl only brought up memory in the 'movable' state. Add
> a new interface to online memory in the non-movable state.
>
> Link: https://github.com/pmem/ndctl/issues/110
> Cc: Ben Olson <ben.olson@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
