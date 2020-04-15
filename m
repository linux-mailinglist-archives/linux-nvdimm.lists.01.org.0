Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8D1A9B1C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 12:43:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F6EE10106309;
	Wed, 15 Apr 2020 03:44:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.68; helo=mail-wr1-f68.google.com; envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D11810106308
	for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 03:44:12 -0700 (PDT)
Received: by mail-wr1-f68.google.com with SMTP id k11so17909272wrp.5
        for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 03:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4/j6DsdU58IfdYBzmmkMpF8PTjT5JEuky8VhAe+f5Q=;
        b=Mh4AP0JsWXyaCMDluV3xIIzhVBU9cjlpz3e0tubd05/UdFdBlwJODt7CtY0nsSmSeU
         4nV9SL8qN5dFF7+WDJgovMuhikV6WaIbEG4aI2bmIAFZbpf5+AIKg0fCM1MMI1JXUYBb
         0fJJeeGv+VlYzfrMsXALzFHPfDIWmWstbojR81V5EGqvmk9HNkSe2UzL4qYi/EZRHmHt
         zQl0uoRonLzQGA22oCdzmfVUaCUDraDY5PvlWyFPp6nmJeAKSuaAjbwfe19Mh9040jTt
         mfN8B1EpgtaIY/nikvBsdm3iymEjXcPHf0JyxNIWX0I1zgn7/BOSz1eBvxkFAkMytRAE
         89xw==
X-Gm-Message-State: AGi0PuYpKKmGJXtv4GRGsfj5ksdkEEUTdxB+Yz+hJGe7L6sZVRxVvrr5
	+RYrivRNYquSG7lgNVYGK1U=
X-Google-Smtp-Source: APiQypLORd/IKgRFpp7S3dA/ZU6/sxCxycvBJkbVFL1bUdvL8hM/nU4Hz7cjmSOUwFyYBpEH5FNTqg==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr26517718wrc.285.1586947421042;
        Wed, 15 Apr 2020 03:43:41 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id y15sm23209097wro.68.2020.04.15.03.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:43:40 -0700 (PDT)
Date: Wed, 15 Apr 2020 12:43:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v3] mm/memory_hotplug: refrain from adding memory into an
 impossible node
Message-ID: <20200415104338.GF4629@dhcp22.suse.cz>
References: <20200414235812.6158-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200414235812.6158-1-vishal.l.verma@intel.com>
Message-ID-Hash: YBSE2ZQYXJI4BGC6PIWYZOEUWTYPWCL3
X-Message-ID-Hash: YBSE2ZQYXJI4BGC6PIWYZOEUWTYPWCL3
X-MailFrom: mstsxfx@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YBSE2ZQYXJI4BGC6PIWYZOEUWTYPWCL3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 14-04-20 17:58:12, Vishal Verma wrote:
[...]
> +static int check_hotplug_node(int nid)
> +{
> +	int alt_nid;
> +
> +	if (node_possible(nid))
> +		return nid;
> +
> +	alt_nid = numa_map_to_online_node(nid);
> +	if (alt_nid == NUMA_NO_NODE)
> +		alt_nid = first_online_node;
> +	WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
> +		   "node %d expected, but was absent from the node_possible_map, using %d instead\n",
> +		   nid, alt_nid);

I really do not like this. Why should we try to be clever and change the
node id requested by the caller? I would just stick with node_possible
check and be done with this.

-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
