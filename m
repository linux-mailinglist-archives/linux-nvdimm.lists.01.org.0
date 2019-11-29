Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DA210D545
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 Nov 2019 12:56:53 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F1911011350C;
	Fri, 29 Nov 2019 04:00:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04ECB1011350B
	for <linux-nvdimm@lists.01.org>; Fri, 29 Nov 2019 04:00:11 -0800 (PST)
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id fd5d8e3d9f99383b; Fri, 29 Nov 2019 12:56:46 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 14/18] acpi/numa: Up-level "map to online node" functionality
Date: Fri, 29 Nov 2019 12:56:45 +0100
Message-ID: <1753949.6LdYI5zB43@kreacher>
In-Reply-To: <157401275104.43284.15865121806241743141.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401275104.43284.15865121806241743141.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: TKJQAYK7CDFXBQB5QFRIITN2G7E3L4MZ
X-Message-ID-Hash: TKJQAYK7CDFXBQB5QFRIITN2G7E3L4MZ
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TKJQAYK7CDFXBQB5QFRIITN2G7E3L4MZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Sunday, November 17, 2019 6:45:51 PM CET Dan Williams wrote:
> The acpi_map_pxm_to_online_node() helper is used to find the closest
> online node to a given proximity domain. This is used to map devices in
> a proximity domain with no online memory or cpus to the closest online
> node and populate a device's 'numa_node' property. The numa_node
> property allows applications to be migrated "close" to a resource.
> 
> In preparation for providing a generic facility to optionally map an
> address range to its closest online node, or the node the range would
> represent were it to be onlined (target_node), up-level the core of
> acpi_map_pxm_to_online_node() to a generic mm/numa helper.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

It looks like this is the only patch in the series needing my attention and
it is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa.c  |   41 -----------------------------------------
>  include/linux/acpi.h |   23 ++++++++++++++++++++++-
>  include/linux/numa.h |    9 +++++++++
>  mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index eadbf90e65d1..47b4969d9b93 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
>  }
>  EXPORT_SYMBOL(acpi_map_pxm_to_node);
>  
> -/**
> - * acpi_map_pxm_to_online_node - Map proximity ID to online node
> - * @pxm: ACPI proximity ID
> - *
> - * This is similar to acpi_map_pxm_to_node(), but always returns an online
> - * node.  When the mapped node from a given proximity ID is offline, it
> - * looks up the node distance table and returns the nearest online node.
> - *
> - * ACPI device drivers, which are called after the NUMA initialization has
> - * completed in the kernel, can call this interface to obtain their device
> - * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> - * offline nodes.  A node may be offline when a device proximity ID is
> - * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> - * "numa=off" on x86.
> - */
> -int acpi_map_pxm_to_online_node(int pxm)
> -{
> -	int node, min_node;
> -
> -	node = acpi_map_pxm_to_node(pxm);
> -
> -	if (node == NUMA_NO_NODE)
> -		node = 0;
> -
> -	min_node = node;
> -	if (!node_online(node)) {
> -		int min_dist = INT_MAX, dist, n;
> -
> -		for_each_online_node(n) {
> -			dist = node_distance(node, n);
> -			if (dist < min_dist) {
> -				min_dist = dist;
> -				min_node = n;
> -			}
> -		}
> -	}
> -
> -	return min_node;
> -}
> -EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
> -
>  static void __init
>  acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 8b4e516bac00..aeedd09f2f71 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);
>  
>  #ifdef CONFIG_ACPI_NUMA
> -int acpi_map_pxm_to_online_node(int pxm);
>  int acpi_map_pxm_to_node(int pxm);
>  int acpi_get_node(acpi_handle handle);
> +
> +/**
> + * acpi_map_pxm_to_online_node - Map proximity ID to online node
> + * @pxm: ACPI proximity ID
> + *
> + * This is similar to acpi_map_pxm_to_node(), but always returns an online
> + * node.  When the mapped node from a given proximity ID is offline, it
> + * looks up the node distance table and returns the nearest online node.
> + *
> + * ACPI device drivers, which are called after the NUMA initialization has
> + * completed in the kernel, can call this interface to obtain their device
> + * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> + * offline nodes.  A node may be offline when a device proximity ID is
> + * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> + * "numa=off" on x86.
> + */
> +static inline int acpi_map_pxm_to_online_node(int pxm)
> +{
> +	int node = acpi_map_pxm_to_node(pxm);
> +
> +	return numa_map_to_online_node(node);
> +}
>  #else
>  static inline int acpi_map_pxm_to_online_node(int pxm)
>  {
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 110b0e5d0fb0..20f4e44b186c 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -13,4 +13,13 @@
>  
>  #define	NUMA_NO_NODE	(-1)
>  
> +#ifdef CONFIG_NUMA
> +int numa_map_to_online_node(int node);
> +#else
> +static inline int numa_map_to_online_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
> +#endif
> +
>  #endif /* _LINUX_NUMA_H */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..e2d8dd21ce9d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
>  
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
> +/**
> + * numa_map_to_online_node - Find closest online node
> + * @nid: Node id to start the search
> + *
> + * Lookup the next closest node by distance if @nid is not online.
> + */
> +int numa_map_to_online_node(int node)
> +{
> +	int min_node;
> +
> +	if (node == NUMA_NO_NODE)
> +		node = 0;
> +
> +	min_node = node;
> +	if (!node_online(node)) {
> +		int min_dist = INT_MAX, dist, n;
> +
> +		for_each_online_node(n) {
> +			dist = node_distance(node, n);
> +			if (dist < min_dist) {
> +				min_dist = dist;
> +				min_node = n;
> +			}
> +		}
> +	}
> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(numa_map_to_online_node);
> +
>  struct mempolicy *get_task_policy(struct task_struct *p)
>  {
>  	struct mempolicy *pol = p->mempolicy;
> 



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
