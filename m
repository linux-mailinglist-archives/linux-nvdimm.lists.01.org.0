Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37942217FBF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 08:44:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BD44110BC284;
	Tue,  7 Jul 2020 23:44:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6716110BC281
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 23:44:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so22969384eja.9
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3S5tywqz97erjS7LDzXGuHTrdnZD9VUuldP8+itAa4=;
        b=wNd/BPeyXfjIe9yIh34g3N8qUwFz9ejUIZFpntOXvJnwbBzo/+oz8abHw3rWSPuac9
         nqBaSoZK3Gy3yDqwdX2f/vp0IOteYuV7fzbQLe3PRgLLKe4tjlA7S17w1H2qEsImmbqQ
         lS/4zO1NKhijvhCJOaJVWNT9pkkEcByZXljDcxLjfb1YfdDt5VEgx7xrG3rJnb3ztz1Y
         Wax2NeMhGGhftDM3IILIDFrh81bWe0QWll2I98iAlA1u7WQSpiQ9Ye163WAyu8mijWiU
         oiOH838fBNvZlkyVB5A/7OY3CN4Wvcvj+knJQlpRhDPsOTmqBla+/PjydbM3II5CnTJ0
         Xawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3S5tywqz97erjS7LDzXGuHTrdnZD9VUuldP8+itAa4=;
        b=XHfrlUE76Ul6V8+pTttqmoEHmXSlII4hARdHaC83uSomUiQjLqMQzQaX9cPiu4IxQ2
         B2tW1lHijtNWhrwr/YCx9GKkJLilK/7pFVMMWQDIict7qk1TQZjjvYr8xaoKM6dXeoz/
         gR9jFJi2luJ8OSkANHGgZHuxhaJZlz7uAlfRUpqTquFnCkGkBMVUpaenfqu/wDxCLJLW
         5UQK9F27CcttdkX21hgQyo7rOgq9K8tluQMvUwFcwifzkZ+JwYyNturRg8bXqALFybGd
         E9xnisU0VRPqq92/YQrE4BwMZ4EO7siaD8aSrynTLT1he8911hh7Dh7s46c6vO9+3PDf
         2SPA==
X-Gm-Message-State: AOAM5329myJBstsnrS/OOjdC5bWYDHmtpEN4HR8Tb7u6kZr0bs/WnsuX
	Ri30RZKrM0yxkrJyT9LQ4R+USqKQHtsYsdu7jHjA1g==
X-Google-Smtp-Source: ABdhPJx4SQlGZTtKojNW/mWzWPOIk3H66jdIvXjAOSf3+ZTHKHnHHoak+j4hKVLWKfpDLoxfuBGf+OkOtlqLn0keYoQ=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr49967426ejb.124.1594190666893;
 Tue, 07 Jul 2020 23:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <20200708053239.GC386073@linux.ibm.com> <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
 <20200708061934.GD386073@linux.ibm.com>
In-Reply-To: <20200708061934.GD386073@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jul 2020 23:44:15 -0700
Message-ID: <CAPcyv4j-vs5pJhr=e3PbuydSfxiEdj_Z5TAvui+pvu28SmgiEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: Mike Rapoport <rppt@linux.ibm.com>
Message-ID-Hash: OQQ32SOEAOGG4WG53CNANJWLPULO7ZTQ
X-Message-ID-Hash: OQQ32SOEAOGG4WG53CNANJWLPULO7ZTQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OQQ32SOEAOGG4WG53CNANJWLPULO7ZTQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2020 at 11:20 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
[..]
> > Darn, I saw ARCH_KEEP_MEMBLOCK and had delusions of grandeur that it
> > could solve my numa api woes. At least for x86 the problem is already
> > solved with reserved numa_meminfo, but now I'm trying to write generic
> > drivers that use those apis and finding these gaps on other archs.
>
> I'm not sure if x86's numa_meminfo is a part of the solution or a part
> of the problem ;-)

More the latter, but hopefully it can remain an exception and not the rule.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
