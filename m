Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC81C7241
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 May 2020 15:57:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 003521162F7CC;
	Wed,  6 May 2020 06:55:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59A0D1162F7CA
	for <linux-nvdimm@lists.01.org>; Wed,  6 May 2020 06:55:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so2778950wmh.3
        for <linux-nvdimm@lists.01.org>; Wed, 06 May 2020 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xxwlHsLDdr/018bY2TiA68tltVHydrJNhbqNoXLbaU=;
        b=Y7SCliGwj7h20Gk7fJZNp6xUGHU7EDL4FWzGSnxo+G9pSsXIMlhbCq68+JvrrXamOw
         TMQ1VnHoUAOFPBZXAJZ3RUuV6G28rlc1koZMvkLlRfiNHoT1WQdeD+mQwlYVJMelaP4d
         vbG44T7/5OJfdOM6zzRl20AsLk95UkoDQ+ClE2YJxAq7gAHs5tMx1dTGqExoFoz0hrwp
         Kjc1141FsXnu0jlcqG02VzoKefaenvBRpcfqxAZuKrmUS0VLJZ7a3DHJJkSTXDQtsrtB
         LZz3AKHpzjQ6SkBPDoNAoxH3cMjjg5e3qZRSkPYvrWuu/APxBTHPeb6q3oQrbrynGc0B
         GRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xxwlHsLDdr/018bY2TiA68tltVHydrJNhbqNoXLbaU=;
        b=LsU+QNDFjuH8MVZ+r1DAz+frOezQvEOp5S3rQPWXm7nMk5IoN6lEdDVvAaCIJP5BS+
         wbTM6vCP6RLHVxm77gV2DkCqyRL1g1sdJkGgF20oFLeKLBvfBI8dz4DuGNV9/Je8a4Ek
         /V8nADKY/ChguXdKWVAPKg0pokNKq/RM5xDK66pscvRLc84FbwuNOg//5LgEjro+Pgiq
         XhqWjIbkID0p5Qi0QRFNIJ9aaCwBn55oCOLmi7Or/WCulEj288zu4IQLADNYmZJYbMat
         oYrHxivLbbf6B4E77bLX6C3OeHtVR7uwtb1TA2HJMNN1IApJFBQ9+8aD2o9HsTfe2D/2
         y10Q==
X-Gm-Message-State: AGi0PuYlfuktbEocK1pieaVpZacaKNkMS9207VhR5i6LtIpfazxWld0Z
	fHKKOzn5Fur/fRre2+skcTarGWimAPtkcNhwU7Mm64AcdLY=
X-Google-Smtp-Source: APiQypL4VMesTiDq72ToI4nwLD5vOm5Ct5PCWh8/QsIaVoqZt2Pa79HPIBdIn5d5JI0xhmKj/3R4YfIJLPBbDORQQ8A=
X-Received: by 2002:a1c:e087:: with SMTP id x129mr4704771wmg.127.1588773444883;
 Wed, 06 May 2020 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200504190227.18269-1-david@redhat.com> <20200504190227.18269-2-david@redhat.com>
In-Reply-To: <20200504190227.18269-2-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 May 2020 15:57:13 +0200
Message-ID: <CAM9Jb+hni2G69n5djfY7mqFALhk9QxGgyr1dkkGx4VTJLmhGGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/memory_hotplug: Introduce add_memory_device_managed()
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: KCKKSOALXF32GPNMGYEUXM4IRZXXHYNE
X-Message-ID-Hash: KCKKSOALXF32GPNMGYEUXM4IRZXXHYNE
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KCKKSOALXF32GPNMGYEUXM4IRZXXHYNE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good to me.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
