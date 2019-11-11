Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A4F83AF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 00:38:42 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA5E6100EA55B;
	Mon, 11 Nov 2019 15:40:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 860FC100EA549
	for <linux-nvdimm@lists.01.org>; Mon, 11 Nov 2019 15:40:30 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id v138so13101956oif.6
        for <linux-nvdimm@lists.01.org>; Mon, 11 Nov 2019 15:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Je0ZHWOZ2BYPwu3RBQEhmnYKnwtQzjlQ/fRKdAJeE0=;
        b=n6pipo/jXtxIMwwDDb0G7uOF3sUaQpbnwzvN4VwrgnmX2npSflOiNj4eTQklfK8yGr
         UEtJEA+ym9HMzyhMRQqZee/nMBU1jZcqaP1JAynpxKac6y2ywNrh7WYsPgSMPFNk6IPS
         KtmxFIEH4NwWjqrS/fIClOqQ0stA9FySbQqh6RIRcHFtoSr2U8pt7vvninOoUx7gopnL
         mxys2gFipifhwQyfwyZL31tvuEzp7t/JJ77RciRCEcHmu8JW1xcm4oQ0awmMgvO1+ExK
         gvroIXNjroxQcj1YHEapR7OvVbU7SgCUtQP7Dcj/eQGzGI2J/XSZ2vMXwLWYuzpa5Fpp
         z45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Je0ZHWOZ2BYPwu3RBQEhmnYKnwtQzjlQ/fRKdAJeE0=;
        b=hSoAEi0hOqa7kNMIs2GCRVgS8nAFIuWUxQfOVTuX6hilu4P01r8MBChtDVq2QfQp1P
         tDNpE7XzYUGfk23hHr5IGiB8Rf4k49+CHN293nPAiu+iRW6EatuxLmCiffkqa2xj58A5
         SS+WLLniEmWnb8cdNzEyJ71DqwKhNFwv2E8DefGm0vevWWuR+lsfp1VisoinA4Hfpte/
         rIjbCvSWT0yZaDBinQIi08P3W1WB1tqgwCmBMi62TSec5AFlyw79eYS727HmnRaBk9EB
         nxyaW1BL9UbZsU3dhGkdvNBA4ZG9HEqG+QqoCnMotPkmH4Nv9AmaAhqa2GWnRvdptpzI
         ZmgQ==
X-Gm-Message-State: APjAAAW/BjSG7FERMEM0CqtSMpbfakBnl048XVyyMn7lfKrPtok70+Fy
	36D4dplOAPIfmV4/LgzYeLRymHqUUttSp5fZfOqgEA==
X-Google-Smtp-Source: APXvYqxbZsJ10V6w2wbRLO2yReepeG/YOZZdYR2sRldcmu5tb3vyid9/nPtAaX9cvPrYo9Vbgae2nzHJH34Hm79jWOQ=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr1304656oia.70.1573515517596;
 Mon, 11 Nov 2019 15:38:37 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309906694.1582359.4777838043061104635.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87v9rq8xb5.fsf@linux.ibm.com>
In-Reply-To: <87v9rq8xb5.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 11 Nov 2019 15:38:26 -0800
Message-ID: <CAPcyv4jbRNo3A-Utsjt6N-iubR8z_NMxPSWeeGZhr3-gjmMC9A@mail.gmail.com>
Subject: Re: [PATCH 13/16] acpi/mm: Up-level "map to online node" functionality
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: O2YJK74QNI4XEKHAXXPIW75MAJ7GLIKR
X-Message-ID-Hash: O2YJK74QNI4XEKHAXXPIW75MAJ7GLIKR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O2YJK74QNI4XEKHAXXPIW75MAJ7GLIKR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 11, 2019 at 3:39 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The acpi_map_pxm_to_online_node() helper is used to find the closest
> > online node to a given proximity domain. This is used to map devices in
> > a proximity domain with no online memory or cpus to the closest online
> > node and populate a device's 'numa_node' property. The numa_node
> > property allows applications to be migrated "close" to a resource.
> >
> > In preparation for providing a generic facility to optionally map an
> > address range to its closest online node, or the node the range would
> > represent were it to be onlined (target_node), up-level the core of
> > acpi_map_pxm_to_online_node() to a generic mm/numa helper.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/acpi/numa.c  |   41 -----------------------------------------
> >  include/linux/acpi.h |   23 ++++++++++++++++++++++-
> >  include/linux/numa.h |    2 ++
> >  mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
> >  4 files changed, 54 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index eadbf90e65d1..47b4969d9b93 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
> >  }
> >  EXPORT_SYMBOL(acpi_map_pxm_to_node);
> >
> > -/**
> > - * acpi_map_pxm_to_online_node - Map proximity ID to online node
> > - * @pxm: ACPI proximity ID
> > - *
> > - * This is similar to acpi_map_pxm_to_node(), but always returns an online
> > - * node.  When the mapped node from a given proximity ID is offline, it
> > - * looks up the node distance table and returns the nearest online node.
> > - *
> > - * ACPI device drivers, which are called after the NUMA initialization has
> > - * completed in the kernel, can call this interface to obtain their device
> > - * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> > - * offline nodes.  A node may be offline when a device proximity ID is
> > - * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> > - * "numa=off" on x86.
> > - */
> > -int acpi_map_pxm_to_online_node(int pxm)
> > -{
> > -     int node, min_node;
> > -
> > -     node = acpi_map_pxm_to_node(pxm);
> > -
> > -     if (node == NUMA_NO_NODE)
> > -             node = 0;
> > -
> > -     min_node = node;
> > -     if (!node_online(node)) {
> > -             int min_dist = INT_MAX, dist, n;
> > -
> > -             for_each_online_node(n) {
> > -                     dist = node_distance(node, n);
> > -                     if (dist < min_dist) {
> > -                             min_dist = dist;
> > -                             min_node = n;
> > -                     }
> > -             }
> > -     }
> > -
> > -     return min_node;
> > -}
> > -EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
> > -
> >  static void __init
> >  acpi_table_print_srat_entry(struct acpi_subtable_header *header)
> >  {
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 8b4e516bac00..aeedd09f2f71 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
> >  extern bool acpi_osi_is_win8(void);
> >
> >  #ifdef CONFIG_ACPI_NUMA
> > -int acpi_map_pxm_to_online_node(int pxm);
> >  int acpi_map_pxm_to_node(int pxm);
> >  int acpi_get_node(acpi_handle handle);
> > +
> > +/**
> > + * acpi_map_pxm_to_online_node - Map proximity ID to online node
> > + * @pxm: ACPI proximity ID
> > + *
> > + * This is similar to acpi_map_pxm_to_node(), but always returns an online
> > + * node.  When the mapped node from a given proximity ID is offline, it
> > + * looks up the node distance table and returns the nearest online node.
> > + *
> > + * ACPI device drivers, which are called after the NUMA initialization has
> > + * completed in the kernel, can call this interface to obtain their device
> > + * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> > + * offline nodes.  A node may be offline when a device proximity ID is
> > + * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> > + * "numa=off" on x86.
> > + */
> > +static inline int acpi_map_pxm_to_online_node(int pxm)
> > +{
> > +     int node = acpi_map_pxm_to_node(pxm);
> > +
> > +     return numa_map_to_online_node(node);
> > +}
> >  #else
> >  static inline int acpi_map_pxm_to_online_node(int pxm)
> >  {
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 110b0e5d0fb0..4fd80f42be43 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -13,4 +13,6 @@
> >
> >  #define      NUMA_NO_NODE    (-1)
> >
> > +int numa_map_to_online_node(int node);
> > +
> >  #endif /* _LINUX_NUMA_H */
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4ae967bcf954..e2d8dd21ce9d 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
> >
> >  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> >
> > +/**
> > + * numa_map_to_online_node - Find closest online node
> > + * @nid: Node id to start the search
> > + *
> > + * Lookup the next closest node by distance if @nid is not online.
> > + */
> > +int numa_map_to_online_node(int node)
> > +{
> > +     int min_node;
> > +
> > +     if (node == NUMA_NO_NODE)
> > +             node = 0;
>
> The ppc64 variant papr_scm_node return the NUMA_NO_NODE in this case.
> Most of the mm helpers can handle with that value . So instead of
> forcing node = 0, let the subsystem decide what to do with the
> NUMA_NO_NODE value.?
>
> > +
> > +     min_node = node;
> > +     if (!node_online(node)) {
> > +             int min_dist = INT_MAX, dist, n;
> > +
> > +             for_each_online_node(n) {
> > +                     dist = node_distance(node, n);
> > +                     if (dist < min_dist) {
> > +                             min_dist = dist;
> > +                             min_node = n;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return min_node;
> > +}
> > +EXPORT_SYMBOL_GPL(numa_map_to_online_node);
> > +
> >  struct mempolicy *get_task_policy(struct task_struct *p)
> >  {
> >       struct mempolicy *pol = p->mempolicy;
>
>
> Can we also switch papr_scm_node to numa_map_to_online_node()?

Sure, I'll take a look.

May I ask for a review of patches 1-12? Should be quick as they're
mostly following the same theme.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
